
 // 2^NxM DUAL PORT SYNCHRONOUS RAM
 // N=NO.OF ADDRESS LINES
 // M=LENGTH OF  WORD IN BITS IN EACH MEMORY LOCATION

  module dual_port_sync_ram(data_in_a,data_in_b,addr_a,addr_b,wr_a,wr_b,data_out_a,data_out_b,clk);

   parameter N=6,M=8;

  input [M-1:0] data_in_a,data_in_b;
  input [N-1:0] addr_a,addr_b;
  input wr_a,wr_b,clk;

  output  reg [M-1:0]  data_out_a,data_out_b;


  // RAM DECLARATION

  reg [M-1:0] ram [0:2**N-1];
  
  // For port A

  always@(posedge clk)
  begin
   if(wr_a)
   begin
     ram[addr_a]<=data_in_a;
     // data_out is required to have the value written because
     // we may want to read and write the data at the same address
     data_out_a<=data_in_a;
   end
   else
    begin
      data_out_a<=ram[addr_a];
    end
end


 // For port B

  always@(posedge clk)
  begin
   if(wr_b)
   begin
     ram[addr_b]<=data_in_b;
     // data_out is required to have the value written because
     // we may want to read and write the data at the same address
     data_out_b<=data_in_b;
   end
   else
    begin
      data_out_b<=ram[addr_b];
    end
end


endmodule
