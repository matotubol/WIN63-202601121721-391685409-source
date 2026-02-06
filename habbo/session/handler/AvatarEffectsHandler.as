package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageEventParser;
   
   public class AvatarEffectsHandler extends BaseHandler
   {
      
      public function AvatarEffectsHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
      }
      
      private function onAvatarEffects(param1:IMessageEvent) : void
      {
         var _loc3_:AvatarEffectsMessageEvent = param1 as AvatarEffectsMessageEvent;
         var _loc2_:AvatarEffectsMessageEventParser = _loc3_.getParser() as AvatarEffectsMessageEventParser;
         class_21.log("Received active avatar effects: " + _loc2_.effects);
         if(listener && listener.events)
         {
         }
      }
   }
}

