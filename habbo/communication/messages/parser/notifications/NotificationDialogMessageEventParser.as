package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class NotificationDialogMessageEventParser implements IMessageParser
   {
      
      private var var_230:String;
      
      private var _parameters:class_55;
      
      public function NotificationDialogMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_230 = null;
         _parameters = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_230 = param1.readString();
         _parameters = new class_55();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc5_:String = param1.readString();
            var _loc4_:String = param1.readString();
            _parameters.add(null,null);
            _loc3_++;
         }
         return true;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get parameters() : class_55
      {
         return _parameters;
      }
   }
}

