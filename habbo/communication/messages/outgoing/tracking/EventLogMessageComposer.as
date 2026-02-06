package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class EventLogMessageComposer implements IMessageComposer
   {
      
      private var var_191:String;
      
      private var var_230:String;
      
      private var _action:String;
      
      private var _extraString:String;
      
      private var var_3849:int;
      
      public function EventLogMessageComposer(param1:String, param2:String, param3:String, param4:String = "", param5:int = 0)
      {
         super();
         var_191 = param1 ? param1 : "";
         var_230 = param2 ? param2 : "";
         _action = param3 ? param3 : "";
         _extraString = param4 ? param4 : "";
         var_3849 = param5 ? param5 : 0;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_191,var_230,_action,_extraString,var_3849];
      }
   }
}

