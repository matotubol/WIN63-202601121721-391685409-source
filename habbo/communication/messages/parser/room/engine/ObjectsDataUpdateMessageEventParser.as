package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_3265;
   
   [SecureSWF(rename="true")]
   public class ObjectsDataUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_411:Array = [];
      
      public function ObjectsDataUpdateMessageEventParser()
      {
         super();
      }
      
      public function get objectCount() : int
      {
         return var_411.length;
      }
      
      public function getObjectData(param1:int) : class_3265
      {
         if(param1 < 0 || param1 >= objectCount)
         {
            return null;
         }
         return var_411[param1];
      }
      
      public function flush() : Boolean
      {
         var_411 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:IStuffData = null;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.readInteger();
            _loc2_ = class_3692.parseStuffData(param1);
            _loc6_ = 0;
            _loc7_ = parseFloat(_loc2_.getLegacyString());
            if(!isNaN(_loc7_))
            {
               _loc6_ = int(_loc2_.getLegacyString());
            }
            var_411.push(new class_3265(_loc5_,_loc6_,_loc2_));
            _loc4_++;
         }
         return true;
      }
   }
}

