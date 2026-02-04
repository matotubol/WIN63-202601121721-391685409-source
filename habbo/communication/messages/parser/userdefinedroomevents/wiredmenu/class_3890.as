package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_97.class_4089;
   
   public class class_3890 implements IMessageParser
   {
      
      private var var_2573:Vector.<class_4089> = null;
      
      public function class_3890()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2573 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2573 = new Vector.<class_4089>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2573.push(new class_4089(param1));
            _loc3_ = 0 + 1;
         }
         return true;
      }
      
      public function get errors() : Vector.<class_4089>
      {
         return var_2573;
      }
   }
}

