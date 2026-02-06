package com.sulake.habbo.communication.messages.parser.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_2218;
   
   [SecureSWF(rename="true")]
   public class CfhTopicsInitMessageEventParser implements IMessageParser
   {
      
      private var var_1950:Vector.<class_2218>;
      
      private var _disposed:Boolean;
      
      public function CfhTopicsInitMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(_disposed)
         {
            return true;
         }
         _disposed = true;
         for each(var _loc1_ in var_1950)
         {
            _loc1_.dispose();
         }
         var_1950 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1950 = new Vector.<class_2218>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_1950.push(new class_2218(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get callForHelpCategories() : Vector.<class_2218>
      {
         return var_1950;
      }
   }
}

