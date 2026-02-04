package com.sulake.habbo.catalog.clubcenter.util
{
   import com.sulake.habbo.session.ISessionDataManager;
   import flash.display.BitmapData;
   
   public class BadgeResolver
   {
      
      public static const DEFAULT_BADGE:String = "HC1";
      
      public static const CLUB_BADGES:Array = ["ACH_VipHC1","ACH_VipHC2","ACH_VipHC3","ACH_VipHC4","ACH_VipHC5","HC1","HC2","HC3","HC4","HC5"];
      
      public function BadgeResolver()
      {
         super();
      }
      
      public static function resolveClubBadgeId(param1:Array) : String
      {
         var _loc3_:String = null;
         for each(var _loc2_ in CLUB_BADGES)
         {
            if(param1.indexOf(_loc2_) > -1)
            {
               _loc3_ = _loc2_;
            }
         }
         return _loc3_;
      }
      
      public static function resolveBadgeBitmap(param1:String, param2:Function, param3:ISessionDataManager) : BitmapData
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:BitmapData = param3.requestBadgeImage(param1);
         if(_loc4_ == null)
         {
            param3.events.addEventListener("BIRE_BADGE_IMAGE_READY",param2);
         }
         return _loc4_;
      }
   }
}

