package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.room.IAreaHideInfo;
   
   public class AreaHideMessageData implements IAreaHideInfo
   {
      
      private var var_2536:int;
      
      private var _on:Boolean;
      
      private var var_1509:int;
      
      private var var_1754:int;
      
      private var _width:int;
      
      private var _length:int;
      
      private var var_4463:Boolean;
      
      public function AreaHideMessageData(param1:IMessageDataWrapper)
      {
         super();
         var_2536 = param1.readInteger();
         _on = param1.readBoolean();
         var_1509 = param1.readInteger();
         var_1754 = param1.readInteger();
         _width = param1.readInteger();
         _length = param1.readInteger();
         var_4463 = param1.readBoolean();
      }
      
      public function get furniId() : int
      {
         return var_2536;
      }
      
      public function get on() : Boolean
      {
         return _on;
      }
      
      public function get rootX() : int
      {
         return var_1509;
      }
      
      public function get rootY() : int
      {
         return var_1754;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get length() : int
      {
         return _length;
      }
      
      public function get invert() : Boolean
      {
         return var_4463;
      }
   }
}

