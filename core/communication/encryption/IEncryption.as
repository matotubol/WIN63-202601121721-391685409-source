package com.sulake.core.communication.encryption
{
   import flash.utils.ByteArray;
   
   public interface IEncryption
   {
      
      function init(param1:ByteArray) : void;
      
      function encipher(param1:ByteArray) : void;
      
      function decipher(param1:ByteArray) : void;
      
      function mark() : void;
      
      function reset() : void;
   }
}

