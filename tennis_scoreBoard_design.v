////////////////////////////////////////////////
//
// Name:   Shubhi Agrawal
// Design: Tennis_ScoreBoard
// Date:   21-05-2021
//
///////////////////////////////////////////////





`timescale 1ns/1ns


module tennis(
            input pl1,
	          pl2,
		  rst,
		  clk,
        output p1_win,
        	p2_win
                    );

  reg [4:0]state, next_state ;

  parameter Idle  =  5'd0,
            p1ayer15 = 5'd1,
            p2ayer15 = 5'd2,
            p1ayer30 = 5'd3,
            p2ayer30 = 5'd4,
            p12ayer15 = 5'd5,
            p1ayer40 = 5'd6,
            p2ayer40 = 5'd7,
            p12ayer31 = 5'd8,
            p21ayer13 = 5'd9,
            p12ayer41 = 5'd10,
            p12ayer14 = 5'd11,
            deuce = 5'd12,
            adv1 = 5'd13,
            adv2 = 5'd14,
            win1 = 5'd15,
            win2 = 5'd16 ;
           
           
 // output logic
 assign {p1_win, p2_win} = (state == win1) ? {2'b10} : ((state == win2) ? {2'b01} : 2'd0 ) ;

 always @(posedge clk)
  begin
  if(!rst)
   state <= 0;
  else
   state <= next_state;
  end

 always @(*)
 begin
  case(state)
  
  Idle: begin
        if(pl1)
         next_state = p1ayer15 ;
        else if(pl2)
         next_state = p2ayer15 ;
        else
          $display("undefined");
        end
  
  p1ayer15: begin
            if(pl1)
              next_state = p1ayer30 ;
            else if(pl2)
              next_state = p12ayer15 ;
            else
              $display("undefined");
            end

   p2ayer15: begin
            if(pl1)
              next_state = p12ayer15 ;
            else if(pl2)
              next_state = p2ayer30 ;
            else
              $display("undefined");
            end
  
   p1ayer30: begin
             if(pl1)
               next_state = p1ayer40 ;
             else if(pl2)
               next_state = p12ayer31 ;
             else
               $display("undefined");
            end

   p2ayer30: begin
             if(pl1)
               next_state = p21ayer13 ;
             else if(pl2)
               next_state = p2ayer40 ;
             else
               $display("undefined");
            end

   p12ayer15: begin
              if(pl1)
               next_state = p12ayer31 ;
             else if(pl2)
               next_state = p21ayer13 ;
             else
               $display("undefined");
            end

   p1ayer40: begin
             if(pl1)
               next_state = win1 ;
             else if(pl2)
               next_state = p12ayer41 ;
             else
               $display("undefined");
            end

   p2ayer40: begin
             if(pl1)
               next_state = p12ayer14 ; 
             else if(pl2)
               next_state = win2 ;
             else
               $display("undefined");
            end
   p12ayer31: begin
              if(pl1)
                next_state = p12ayer41 ; 
              else if(pl2)
                next_state = deuce ;
              else
                $display("undefined");
             end

  p21ayer13: begin
              if(pl1)
                next_state = deuce ; 
              else if(pl2)
                next_state = p12ayer14 ;
              else
                $display("undefined");
             end

   p12ayer41: begin
              if(pl1)
                next_state = win1 ; 
              else if(pl2)
                next_state = adv1 ;
              else
                $display("undefined");
             end

   p12ayer14: begin
              if(pl1)
                next_state = adv2 ; 
              else if(pl2)
                next_state = win2 ;
              else
                $display("undefined");
             end

     deuce: begin
              if(pl1)
                next_state = adv1 ; 
              else if(pl2)
                next_state = adv2 ;
              else
                $display("undefined");
             end

   adv1: begin
              if(pl1)
                next_state = win1 ; 
              else if(pl2)
                next_state = deuce ;
              else
                $display("undefined");
             end

   adv2: begin
              if(pl1)
                next_state = deuce ; 
              else if(pl2)
                next_state = win2 ;
              else
                $display("undefined");
             end
   win1: next_state = Idle ;
   win2: next_state = Idle ;
   default: next_state = Idle ;
        endcase
        end
        
  endmodule
