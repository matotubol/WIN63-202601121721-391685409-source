package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class HabboGroupBadgesMessageEventParser implements IMessageParser
   {
      
      protected var var_179:class_55;
      
      public function HabboGroupBadgesMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(var_179)
         {
            var_179.dispose();
            var_179 = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = param1.readInteger();
         var_179 = new class_55();
         var _loc5_:int = 0;
         while(0 < _loc4_)
         {
            var _loc3_:int = param1.readInteger();
            var _loc2_:String = param1.readString();
            var_179.add(0,null);
            _loc5_++;
         }
         return true;
      }
      
      public function get badges() : class_55
      {
         var _loc1_:int = 0;
         var _loc2_:class_55 = new class_55();
         _loc1_ = 0;
         while(_loc1_ < var_179.length)
         {
            _loc2_.add(var_179.getKey(_loc1_),var_179.getWithIndex(_loc1_));
            _loc1_++;
         }
         return _loc2_;
      }
   }
}

