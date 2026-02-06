package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_3647;
   
   [SecureSWF(rename="true")]
   public class ObjectsMessageEventParser implements IMessageParser
   {
      
      private var var_411:Array = [];
      
      public function ObjectsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_411 = [];
         return true;
      }
      
      public function getObjectCount() : int
      {
         return var_411.length;
      }
      
      public function getObject(param1:int) : class_3647
      {
         if(param1 < 0 || param1 >= getObjectCount())
         {
            return null;
         }
         var _loc2_:class_3647 = var_411[param1] as class_3647;
         if(_loc2_ != null)
         {
            _loc2_.setReadOnly();
         }
         return _loc2_;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_411 = [];
         var _loc5_:class_55 = new class_55();
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            var _loc6_:int = param1.readInteger();
            var _loc2_:String = param1.readString();
            _loc5_.add(0,null);
            _loc4_++;
         }
         var _loc7_:int = param1.readInteger();
         _loc4_ = 0;
         while(0 < _loc7_)
         {
            var _loc8_:class_3647 = class_3692.parseObjectData(param1);
            if(_loc8_ != null)
            {
               null.ownerName = _loc5_.getValue(null.ownerId);
               var_411.push(null);
            }
            _loc4_++;
         }
         return true;
      }
   }
}

