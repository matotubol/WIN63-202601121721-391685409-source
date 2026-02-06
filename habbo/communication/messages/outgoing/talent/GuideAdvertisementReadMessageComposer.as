package com.sulake.habbo.communication.messages.outgoing.talent
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GuideAdvertisementReadMessageComposer implements IMessageComposer
   {
      
      public function GuideAdvertisementReadMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
      
      public function dispose() : void
      {
      }
   }
}

