module dual_port_sync_ram_tb;

  parameter N = 6;  // Number of address lines
  parameter M = 8;  // Word length in bits

  // Testbench Signals
  reg [M-1:0] data_in_a, data_in_b;
  reg [N-1:0] addr_a, addr_b;
  reg wr_a, wr_b, clk;
  wire [M-1:0] data_out_a, data_out_b;

  // Instantiate the dual-port synchronous RAM module
  dual_port_sync_ram #(N, M) dut (
    .data_in_a(data_in_a),
    .data_in_b(data_in_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .wr_a(wr_a),
    .wr_b(wr_b),
    .data_out_a(data_out_a),
    .data_out_b(data_out_b),
    .clk(clk)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units clock period
  end

  // Test procedure
  initial begin
    // Initialize inputs
    data_in_a = 0;
    data_in_b = 0;
    addr_a = 0;
    addr_b = 0;
    wr_a = 0;
    wr_b = 0;

    // Wait for reset
    #10;

    // Write to port A
    addr_a = 6'b000001; data_in_a = 8'b10101010; wr_a = 1;
    #10;
    wr_a = 0;

    // Write to port B
    addr_b = 6'b000010; data_in_b = 8'b11001100; wr_b = 1;
    #10;
    wr_b = 0;

    // Read from port A
    addr_a = 6'b000001;
    #10;

    // Read from port B
    addr_b = 6'b000010;
    #10;

    // Simultaneous write and read
    addr_a = 6'b000011; data_in_a = 8'b11110000; wr_a = 1;
    addr_b = 6'b000001; wr_b = 0;
    #10;
    wr_a = 0;

    // End of simulation
    #20;
    $finish;
  end

endmodule
