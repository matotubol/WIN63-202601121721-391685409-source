package com.sulake.habbo.notifications.feed
{
   public class FeedSettings
   {
      
      public static const const_903:int = 0;
      
      public static const const_382:int = 1;
      
      public static const const_286:int = 2;
      
      public static const const_1127:int = 3;
      
      public static const FEED_CATEGORY_ME:int = 0;
      
      public static const const_970:int = 1;
      
      public static const FEED_CATEGORY_HOTEL:int = 2;
      
      private var var_3884:NotificationController;
      
      private var var_1730:Vector.<int>;
      
      public function FeedSettings(param1:NotificationController)
      {
         super();
         var_1730 = new Vector.<int>();
         var_1730.push(1);
         var_1730.push(0);
         var_1730.push(2);
      }
      
      public function dispose() : void
      {
         var_3884 = null;
         var_1730 = null;
      }
      
      public function getVisibleFeedCategories() : Vector.<int>
      {
         return var_1730;
      }
      
      public function toggleVisibleFeedCategory(param1:int) : void
      {
         var_3884.updateFeedCategoryFiltering();
      }
   }
}

