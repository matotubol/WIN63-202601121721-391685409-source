package com.sulake.habbo.communication.messages.outgoing.camera
{
   [SecureSWF(rename="true")]
   public class RenderRoomThumbnailMessageComposer extends RenderRoomMessageComposer
   {
      
      public function RenderRoomThumbnailMessageComposer(param1:Array, param2:String, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         compressData();
      }
   }
}

