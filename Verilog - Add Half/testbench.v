module test();
  reg a, b;
  wire c_out, sum;
  
  Add_half ADD_HALF( .c_out( c_out ), .sum( sum ), .a( a ), .b( b ) );
  
  initial begin
    assign a = 1;
    assign b = 1;
    display;
  end
  
  task display;
    #1 $display( "a:%0h, b:%0h, c_out:%0h, sum:%0h", a, b, c_out, sum );
    // O caractere, \#, e usado para o controle do delay. Obs.: #0 e desencorajado 
  endtask
endmodule
    
