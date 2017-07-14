----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:40:33 07/12/2017 
-- Design Name: 
-- Module Name:    memtest - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memtest is
    Port ( clk: in STD_LOGIC;
			  datain : in integer;
           enable : in STD_LOGIC;
           status : in STD_LOGIC;
           output : in STD_LOGIC);
end memtest;

architecture basic of memtest is

COMPONENT asciiRAM
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
  );
END COMPONENT;

signal ena, enb: STD_LOGIC;
signal wea: STD_LOGIC_VECTOR(0 downto 0):="0"; 
signal addra: STD_LOGIC_VECTOR(7 downto 0);
signal dina: STD_LOGIC_VECTOR(6 downto 0);
signal douta: STD_LOGIC_VECTOR(6 DOWNTO 0);
shared variable count: integer range 0 to 255 := 0;
signal increment: std_logic_vector(3 downto 0):="0000";

begin

your_instance_name : asciiRAM
  PORT MAP (
    clka => clk,
    wea => wea,
    addra => addra,
    dina => dina,
    douta => douta
  );

process(clk) is
begin
	if rising_edge(clk) then
		wea <= "1";
		dina <= std_logic_vector(to_unsigned(count, 7));	
		addra <= std_logic_vector(to_unsigned(count, 8));	
			
		if (count = 256) then
			count := 0;
			wea <= "0";
			addra <= "00001000";
		else 
			count := count + 1;
			increment <= increment + 1;
		end if;
	end if;

end process;

end basic;
