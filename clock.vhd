library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clock is 
  port( 
    clk : inout bit
  );
end entity;

architecture behav of clock is 
  begin 
    
    process
      begin 
        clk <= not(clk);
        wait for 100 ns;
    end process;
end architecture;
  
