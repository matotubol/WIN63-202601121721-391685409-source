package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageRequestedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageResultMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageResultMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageRequestedMessageEventParser;
   
   public class PetPackageHandler extends BaseHandler
   {
      
      public function PetPackageHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new OpenPetPackageRequestedMessageEvent(onOpenPetPackageRequested));
         param1.addMessageEvent(new OpenPetPackageResultMessageEvent(onOpenPetPackageResult));
      }
      
      private function onOpenPetPackageRequested(param1:IMessageEvent) : void
      {
         var _loc2_:OpenPetPackageRequestedMessageEventParser = (param1 as OpenPetPackageRequestedMessageEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         if(listener && listener.events)
         {
            listener.events.dispatchEvent(new RoomSessionPetPackageEvent("RSOPPE_OPEN_PET_PACKAGE_REQUESTED",_loc3_,_loc2_.objectId,_loc2_.figureData,0,null));
         }
      }
      
      private function onOpenPetPackageResult(param1:IMessageEvent) : void
      {
         var _loc2_:OpenPetPackageResultMessageEventParser = (param1 as OpenPetPackageResultMessageEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         if(listener && listener.events)
         {
            listener.events.dispatchEvent(new RoomSessionPetPackageEvent("RSOPPE_OPEN_PET_PACKAGE_RESULT",_loc3_,_loc2_.objectId,null,_loc2_.nameValidationStatus,_loc2_.nameValidationInfo));
         }
      }
   }
}

