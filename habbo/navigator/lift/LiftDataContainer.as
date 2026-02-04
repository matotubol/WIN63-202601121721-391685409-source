package com.sulake.habbo.navigator.lift
{
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import package_25.class_2999;
   
   public class LiftDataContainer
   {
      
      private static const DEFAULT_IMAGE:String = "${image.library.url}officialrooms_hq/nav_teaser_wl.png";
      
      private var _navigator:HabboNewNavigator;
      
      private var _liftedRooms:Vector.<class_2999> = new Vector.<class_2999>(0);
      
      public function LiftDataContainer(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function setLiftedRooms(param1:Vector.<class_2999>) : void
      {
         _liftedRooms = param1;
      }
      
      public function get liftedRooms() : Vector.<class_2999>
      {
         return _liftedRooms;
      }
      
      public function getUrlForLiftImageAtIndex(param1:int) : String
      {
         if(param1 < 0 || param1 > _liftedRooms.length - 1)
         {
            return "";
         }
         if(_liftedRooms[param1].image == "")
         {
            return "${image.library.url}officialrooms_hq/nav_teaser_wl.png";
         }
         return _navigator.imageLibraryBaseUrl + _liftedRooms[param1].image;
      }
   }
}

