package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   [SecureSWF(rename="true")]
   public class class_3344
   {
      
      private var var_197:int = 0;
      
      private var var_230:int = 0;
      
      private var _color:uint = 0;
      
      private var var_1711:uint = 0;
      
      private var var_136:Boolean = false;
      
      public function class_3344(param1:int)
      {
         super();
         var_197 = param1;
      }
      
      public function setReadOnly() : void
      {
         var_136 = true;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function set type(param1:int) : void
      {
         if(!var_136)
         {
            var_230 = param1;
         }
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         if(!var_136)
         {
            _color = param1;
         }
      }
      
      public function get light() : int
      {
         return var_1711;
      }
      
      public function set light(param1:int) : void
      {
         if(!var_136)
         {
            var_1711 = param1;
         }
      }
   }
}

