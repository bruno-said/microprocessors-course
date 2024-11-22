module test();
  reg a, b, c_in;
  wire c_out, sum;
  
  full_adder FULL_ADDER( .sum( sum ), .c_out( c_out ), .a( a ), .b( b ), .c_in( c_in ) );
  
  initial begin
    assign a = 0; assign b = 0; assign c_in = 0; display;
    assign a = 0; assign b = 0; assign c_in = 1; display;
    assign a = 0; assign b = 1; assign c_in = 0; display;
    assign a = 0; assign b = 1; assign c_in = 1; display;
    assign a = 0; assign b = 0; assign c_in = 0; display;
    assign a = 0; assign b = 0; assign c_in = 1; display;
    assign a = 0; assign b = 1; assign c_in = 0; display;
    assign a = 0; assign b = 1; assign c_in = 1; display;
    assign a = 1; assign b = 0; assign c_in = 0; display;
    assign a = 1; assign b = 0; assign c_in = 1; display;
    assign a = 1; assign b = 1; assign c_in = 0; display;
    assign a = 1; assign b = 1; assign c_in = 1; display;
    assign a = 1; assign b = 0; assign c_in = 0; display;
    assign a = 1; assign b = 0; assign c_in = 1; display;
    assign a = 1; assign b = 1; assign c_in = 0; display;
    assign a = 1; assign b = 1; assign c_in = 1; display;
  end
  
  task display;
    #1 $display( "a:%0h, b:%0h, c_in:%0h, c_out:%0h, sum:%0h", a, b, c_in, c_out, sum );
    // O caractere, \#, e usado para o controle do delay. Obs.: #0 e desencorajado 
  endtask
endmodule
    
