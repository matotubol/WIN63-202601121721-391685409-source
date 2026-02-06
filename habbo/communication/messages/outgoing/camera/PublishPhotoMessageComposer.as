package com.sulake.habbo.communication.messages.outgoing.camera
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PublishPhotoMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function PublishPhotoMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = [];
      }
   }
}

