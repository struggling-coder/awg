library ieee;
use ieee.std_logic_1164.all;

entity controldac is
  port (
	clk: in std_logic;
	addr: in std_logic_vector(31 downto 0);
	start: in std_logic:= '0';
	trigger, mode: in std_logic_vector(1 downto 0);
	length: in std_logic_vector(13 downto 0)
	repitition: in std_logic_vector(19 downto 0)) ;
end entity ; -- controldac

architecture synth of controldac is

  component outfifo is
	  generic (
	  	word_length:integer := 16;
	  	address_length:integer := 12);
	  port (
		init, clk: in std_logic;
		push, pop: in std_logic;
		full, empty: buffer std_logic;
		datain: in std_logic_vector(word_length-1 downto 0);
		dataout: out std_logic_vector(word_length-1 downto 0)
	  ) ;
  end component;



  begin


end architecture ; -- synth