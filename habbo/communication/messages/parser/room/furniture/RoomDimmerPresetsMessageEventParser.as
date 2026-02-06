package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.class_3344;
   
   [SecureSWF(rename="true")]
   public class RoomDimmerPresetsMessageEventParser implements IMessageParser
   {
      
      private var var_4347:int = 0;
      
      private var var_1484:Array = [];
      
      private var var_2529:int = 0;
      
      private var var_1468:Boolean = false;
      
      public function RoomDimmerPresetsMessageEventParser()
      {
         super();
      }
      
      public function get itemId() : int
      {
         return var_2529;
      }
      
      public function get presetCount() : int
      {
         return var_1484.length;
      }
      
      public function get selectedPresetId() : int
      {
         return var_4347;
      }
      
      public function getPreset(param1:int) : class_3344
      {
         if(param1 < 0 || param1 >= presetCount)
         {
            return null;
         }
         return var_1484[param1];
      }
      
      public function get isOn() : Boolean
      {
         return var_1468;
      }
      
      public function flush() : Boolean
      {
         var_1484 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = param1.readInteger();
         var_4347 = param1.readInteger();
         var _loc5_:int = 0;
         while(0 < _loc4_)
         {
            var _loc7_:int = param1.readInteger();
            var _loc9_:int = param1.readInteger();
            var _loc6_:String = param1.readString();
            var _loc2_:int = parseInt(null.substr(1),16);
            var _loc3_:int = param1.readInteger();
            var _loc8_:class_3344 = new class_3344(0);
            _loc8_.type = 0;
            null.color = 0;
            null.light = 0;
            null.setReadOnly();
            var_1484.push(null);
            _loc5_++;
         }
         var_1468 = param1.readBoolean();
         var_2529 = param1.readInteger();
         return true;
      }
   }
}

