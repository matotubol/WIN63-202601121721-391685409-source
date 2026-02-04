package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import package_135.class_2509;
   import package_135.class_2631;
   import package_167.class_2836;
   import package_167.class_3095;
   import package_167.class_3249;
   
   public class RoomPermissionsHandler extends BaseHandler
   {
      
      public function RoomPermissionsHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new class_3249(onYouAreController));
         param1.addMessageEvent(new class_3095(onYouAreNotController));
         param1.addMessageEvent(new class_2836(onYouAreOwner));
      }
      
      private function onYouAreController(param1:IMessageEvent) : void
      {
         var _loc4_:class_3249 = param1 as class_3249;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:class_2631 = _loc4_.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(_loc2_.flatId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.roomControllerLevel = _loc2_.roomControllerLevel;
      }
      
      private function onYouAreNotController(param1:IMessageEvent) : void
      {
         var _loc4_:class_3095 = param1 as class_3095;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:class_2509 = _loc4_.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(_loc2_.flatId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.roomControllerLevel = 0;
      }
      
      private function onYouAreOwner(param1:IMessageEvent) : void
      {
         var _loc3_:class_2836 = param1 as class_2836;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(var_56);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.isRoomOwner = true;
      }
   }
}

