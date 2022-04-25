--[[
    Modulo para conexão serial do CoppeliaSim EDU com o controlador MK4 do manipulador ED7220cv7
    Utilização:
    local SerialConnection = require "Ed7270SerialConnection"
    SerialConnection.serialConnectionInit()
]]

local SerialConnection =  {}

--[[
   serialConnectionInit()
   Parameters:
      options.portString: a string specifying the port to open.  (STRING)
                  Under Windows, use something similar to "\\.\COM1". 
                  Under MacOS and Linux, use something similar to "/dev/*".
                     You might have to launch CoppeliaSim with super user 
                     priviledges in order to access the serial port.
      options.baudRate: the baudrate = 9600 bps (INT)
      options.reserved1: reserved for future extension. Keep at nullptr.
      options.reserved2: reserved for future extension. Keep at nullptr.
   Return
      -1 if operation was not successful, otherwise a port handle
]]
function SerialConnection.serialConnectionInit(options) -- CallFunction: serialConnectionInit{portString: "\\.\COM1", baudrate: 9600}
   int result=sim.serialOpen(options.portString, options.baudRate) -- ##### VERIFICAR SE É POSSÍVEL DEFINIR A PORTA AUTOMATICAMENTE
   if result == -1 then
      print('Erro de conexão usb')
    else
      return result --portHandle
    end 
end

--[[
   serialConnectionWrite()
   Parameters:
      portHandle: the handle returned by the simSerialOpen function
      data: a pointer to the data that should be sent
      dataLength: length of the data to be sent
   Return
      -1 if operation was not successful, otherwise the effective data length that was written
]]
function SerialConnection.serialConnectionWrite(options) -- options.portHandle= ? ,  options.data = 'PD,F,0'  (STRING)
   
   hex = string.tohex(option.data)
   --Teste
   -- Adicionar o \r no final do comando
   hex = hex.."0D"  --concatena o \r no final do código
   --Teste
   dec = string.fromhex(hex)

	int result=sim.serialSend(int options.portHandle, buffer dec) -- enviar um ponteiro?

   if result == -1 then
      print('Erro de envio usb')
    else
      return result --data length that was written
    end 
  
end

function SerialConnection.serialConnectionRead(args)
  
end

function SerialConnection.routine1(args)
   
   
end


-- AUX
function string.fromhex(str) 
   --return (str:gsub('..', function (cc) -- não funciona
     --  return string.char(tonumber(cc, 16))
   --end))  
   return tonumber(str, 16)  
end

function string.tohex(str)
   return (str:gsub('.', function (c)
       return string.format('%02X', string.byte(c))
   end))
end


return SerialConnection