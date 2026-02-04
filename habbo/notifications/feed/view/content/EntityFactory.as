package com.sulake.habbo.notifications.feed.view.content
{
   import com.sulake.habbo.notifications.feed.data.GenericNotificationItemData;
   import flash.utils.getTimer;
   
   public class EntityFactory
   {
      
      public function EntityFactory()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function createNotificationEntity(param1:GenericNotificationItemData) : class_3007
      {
         if(param1 is GenericNotificationItemData)
         {
            return createGenericFeedEntity(param1);
         }
         return null;
      }
      
      private function createGenericFeedEntity(param1:GenericNotificationItemData) : class_3007
      {
         var _loc2_:FeedEntity = FeedEntity.allocate();
         _loc2_.icon = param1.iconImage;
         _loc2_.title = param1.title;
         _loc2_.minutesElapsed = (param1.timeStamp - getTimer()) / 1000 / 60;
         _loc2_.message = param1.description;
         _loc2_.decoration = param1.decorationImage;
         _loc2_.setButton(param1.buttonAction,param1.buttonCaption);
         _loc2_.updateContainerSize();
         return _loc2_;
      }
   }
}

