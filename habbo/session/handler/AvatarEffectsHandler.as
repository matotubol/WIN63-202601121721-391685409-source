package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import package_124.class_3589;
   import package_86.class_3075;
   
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
         var _loc3_:class_3589 = param1 as class_3589;
         var _loc2_:class_3075 = _loc3_.getParser() as class_3075;
         class_21.log("Received active avatar effects: " + _loc2_.effects);
         if(listener && listener.events)
         {
         }
      }
   }
}

