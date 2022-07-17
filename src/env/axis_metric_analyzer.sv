`ifndef AXIS_METRIC_ANALYZER_SV
`define AXIS_METRIC_ANALYZER_SV

class axis_metric_analyzer #(`DEFAULT_CLS_PARAM_ARGS) extends uvm_subscriber#(ITEM_T);
  
  `uvm_component_param_utils(axis_metric_analyzer#(`DEFAULT_CLS_PARAMS))
  `uvm_component_new

  realtime xfer_arrival_q[$];

  protected realtime last_arrival=0s;

  typedef uint metric_type_t; 
  metric_type_t AVERAGE_XFER_DELAY  = (1 << 0); 
  metric_type_t LONGEST_XFER_DELAY  = (1 << 1); 
  metric_type_t SHORTEST_XFER_DELAY = (1 << 2); 

  metric_type_t metric_type_en = (AVERAGE_XFER_DELAY | LONGEST_XFER_DELAY | SHORTEST_XFER_DELAY); // default

  protected realtime longest_dt=0, shortest_dt=0, average_dt;
  protected realtime current_dt=0;

  function void write(ITEM_T t);
    realtime delay;
    xfer_arrival_q.push_back($realtime);
  endfunction

  function void extract_phase(uvm_phase phase);
    realtime delay_q[$];
    realtime last_arrival;
    uint xfer_size;

    xfer_size = xfer_arrival_q.size();

    // initialization
    last_arrival = xfer_arrival_q.pop_front();
    shortest_dt = last_arrival;

    // calculation
    foreach(xfer_arrival_q[i]) begin
      current_dt = xfer_arrival_q[i] - last_arrival;
      delay_q.push_back(current_dt);

      calc_shortest(current_dt);
      calc_longest(current_dt);
      
      last_arrival = xfer_arrival_q.pop_front();
    end
    calc_average(delay_q);
  endfunction

  protected function void calc_shortest(realtime dt);
    if (metric_type_en & SHORTEST_XFER_DELAY) begin
      if(dt < shortest_dt) shortest_dt = dt;
    end
  endfunction

  protected function void calc_longest(realtime dt);
    if (metric_type_en & LONGEST_XFER_DELAY) begin
      if(dt > longest_dt) longest_dt = dt;
    end
  endfunction

  protected function void calc_average(realtime delay_q[$]);
    realtime sum_delay=0;
    if (metric_type_en & AVERAGE_XFER_DELAY) begin
      foreach(delay_q[i])
      sum_delay += delay_q[i];
      average_dt = sum_delay / delay_q.size();
    end
  endfunction


  function void report_phase(uvm_phase phase);
    if (metric_type_en & SHORTEST_XFER_DELAY)
      `uvm_info(`gfn, $sformatf("Shortest xfer delay: %0t", shortest_dt), UVM_INFO)
    if (metric_type_en & LONGEST_XFER_DELAY)
      `uvm_info(`gfn, $sformatf("Longest xfer delay: %0t", longest_dt), UVM_INFO)
    if (metric_type_en & AVERAGE_XFER_DELAY)
      `uvm_info(`gfn, $sformatf("Average xfer delay: %0t", average_dt), UVM_INFO)
  endfunction

endclass

`endif