package com.sulake.habbo.communication.messages.parser.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MyCfhReportStatusMessageEventParser implements IMessageParser
   {
      
      private var var_2613:Vector.<class_2748>;
      
      public function MyCfhReportStatusMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2613 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2613 = new Vector.<class_2748>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2613.push(new class_2748(param1));
            _loc3_ = 0 + 1;
         }
         return true;
      }
      
      public function get messages() : Vector.<class_2748>
      {
         return var_2613;
      }
   }
}

