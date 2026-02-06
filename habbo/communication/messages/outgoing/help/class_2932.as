package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class class_2932 implements IMessageComposer
   {
      
      private var _searchString:String;
      
      public function class_2932(param1:String)
      {
         super();
         _searchString = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [_searchString];
      }
      
      public function dispose() : void
      {
      }
   }
}

