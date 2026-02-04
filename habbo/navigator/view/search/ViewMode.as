package com.sulake.habbo.navigator.view.search
{
   public class ViewMode
   {
      
      public static const MYWORLD_VIEW_CODE:String = "myworld_view";
      
      public static const HOTEL_VIEW_CODE:String = "hotel_view";
      
      public static const OFFICIAL_VIEW_CODE:String = "official_view";
      
      public static const ROOM_ADS_VIEW_CODE:String = "roomads_view";
      
      public static const NEW_ADS_VIEW_CODE:String = "new_ads";
      
      public static const ADS_VIEW_CODE_PREFIX:String = "eventcategory__";
      
      public static const const_925:int = 0;
      
      public static const MY_WORLD_VIEW:int = 1;
      
      public static const HOTEL_VIEW:int = 2;
      
      public static const ROOM_AD_VIEW:int = 3;
      
      public static const const_1023:int = 4;
      
      public function ViewMode()
      {
         super();
      }
      
      public static function getViewMode(param1:String) : int
      {
         if(param1 == "official_view")
         {
            return 0;
         }
         if(param1 == "myworld_view")
         {
            return 1;
         }
         if(param1 == "roomads_view")
         {
            return 3;
         }
         if(param1 == "new_ads")
         {
            return 4;
         }
         if(param1.indexOf("eventcategory__") == 0)
         {
            return 4;
         }
         return 2;
      }
      
      public static function isEventViewMode(param1:int) : Boolean
      {
         return param1 == 3 || param1 == 4;
      }
   }
}

