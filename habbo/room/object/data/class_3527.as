package com.sulake.habbo.room.object.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class class_3527 extends class_2107 implements IStuffData
   {
      
      public static const FORMAT_KEY:int = 3;
      
      private static const INTERNAL_STATE_KEY:String = "s";
      
      private static const INTERNAL_RESULT_KEY:String = "r";
      
      private var var_61:String = "";
      
      private var var_1122:int;
      
      public function class_3527()
      {
         super();
      }
      
      override public function initializeFromIncomingMessage(param1:IMessageDataWrapper) : void
      {
         var_61 = param1.readString();
         var_1122 = param1.readInteger();
         super.initializeFromIncomingMessage(param1);
      }
      
      override public function writeRoomObjectModel(param1:IRoomObjectModelController) : void
      {
         super.writeRoomObjectModel(param1);
         param1.setNumber("furniture_data_format",3);
         var _loc2_:class_55 = new class_55();
         _loc2_.add("s",var_61);
         _loc2_.add("r",var_1122.toString());
         param1.setStringToStringMap("furniture_data",_loc2_);
      }
      
      override public function initializeFromRoomObjectModel(param1:IRoomObjectModel) : void
      {
         super.initializeFromRoomObjectModel(param1);
         var _loc2_:class_55 = param1.getStringToStringMap("furniture_data");
         var_61 = _loc2_.getValue("s");
         var_1122 = _loc2_.getValue("r");
      }
      
      override public function getLegacyString() : String
      {
         return var_61;
      }
      
      public function setString(param1:String) : void
      {
         var_61 = param1;
      }
      
      public function get result() : int
      {
         return var_1122;
      }
      
      override public function compare(param1:IStuffData) : Boolean
      {
         return true;
      }
   }
}

