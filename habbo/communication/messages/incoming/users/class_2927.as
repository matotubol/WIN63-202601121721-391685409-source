package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2927
   {
      
      private var var_197:int;
      
      private var _color:uint;
      
      public function class_2927(param1:IMessageDataWrapper)
      {
         super();
         var_197 = param1.readInteger();
         _color = parseInt(param1.readString(),16);
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get red() : int
      {
         return _color >> 16 & 0xFF;
      }
      
      public function get green() : int
      {
         return _color >> 8 & 0xFF;
      }
      
      public function get blue() : int
      {
         return _color >> 0 & 0xFF;
      }
   }
}

