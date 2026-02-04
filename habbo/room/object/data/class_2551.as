package com.sulake.habbo.room.object.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class class_2551 extends class_2107 implements IStuffData
   {
      
      public static const FORMAT_KEY:int = 5;
      
      private static const STATE_DEFAULT_INDEX:int = 0;
      
      private var var_24:Array = [];
      
      public function class_2551()
      {
         super();
      }
      
      override public function initializeFromIncomingMessage(param1:IMessageDataWrapper) : void
      {
         var_24 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc4_:int = param1.readInteger();
            var_24.push(0);
            _loc3_++;
         }
         super.initializeFromIncomingMessage(param1);
      }
      
      override public function initializeFromRoomObjectModel(param1:IRoomObjectModel) : void
      {
         super.initializeFromRoomObjectModel(param1);
         var_24 = param1.getNumberArray("furniture_data");
      }
      
      override public function writeRoomObjectModel(param1:IRoomObjectModelController) : void
      {
         super.writeRoomObjectModel(param1);
         param1.setNumber("furniture_data_format",5);
         param1.setNumberArray("furniture_data",var_24);
      }
      
      override public function getLegacyString() : String
      {
         if(!var_24)
         {
            return "";
         }
         return var_24[0];
      }
      
      public function getValue(param1:int) : int
      {
         if(var_24 && param1 < var_24.length)
         {
            return var_24[param1];
         }
         return -1;
      }
      
      public function setArray(param1:Array) : void
      {
         var_24 = param1;
      }
      
      override public function compare(param1:IStuffData) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:class_2551 = param1 as class_2551;
         if(!_loc2_)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < var_24.length)
         {
            if(_loc3_ != 0)
            {
               if(var_24[_loc3_] != _loc2_.getValue(_loc3_))
               {
                  return false;
               }
            }
            _loc3_++;
         }
         return true;
      }
   }
}

