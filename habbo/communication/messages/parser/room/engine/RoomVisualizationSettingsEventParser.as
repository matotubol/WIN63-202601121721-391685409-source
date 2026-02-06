package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomVisualizationSettingsEventParser implements IMessageParser
   {
      
      private var var_3360:Boolean = false;
      
      private var var_2562:Number = 1;
      
      private var var_2043:Number = 1;
      
      public function RoomVisualizationSettingsEventParser()
      {
         super();
      }
      
      public function get wallsHidden() : Boolean
      {
         return var_3360;
      }
      
      public function get wallThicknessMultiplier() : Number
      {
         return var_2562;
      }
      
      public function get floorThicknessMultiplier() : Number
      {
         return var_2043;
      }
      
      public function flush() : Boolean
      {
         var_3360 = false;
         var_2562 = 1;
         var_2043 = 1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_3360 = param1.readBoolean();
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         if(_loc3_ < -2)
         {
            _loc3_ = -2;
         }
         else if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         if(_loc2_ < -2)
         {
            _loc2_ = -2;
         }
         else if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         var_2562 = Math.pow(2,_loc3_);
         var_2043 = Math.pow(2,_loc2_);
         return true;
      }
   }
}

