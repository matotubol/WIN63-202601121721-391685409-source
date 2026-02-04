package com.sulake.habbo.utils
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.class_1758;
   
   public class class_2323
   {
      
      public function class_2323()
      {
         super();
      }
      
      public static function setup(param1:class_1812, param2:Function) : void
      {
         var _loc3_:class_1741 = param1.findChildByName("user_info_region");
         _loc3_.addEventListener("WME_OVER",onUserInfoMouseOver);
         _loc3_.addEventListener("WME_OUT",onUserInfoMouseOut);
         _loc3_.addEventListener("WME_CLICK",param2);
      }
      
      private static function onUserInfoMouseOver(param1:class_1758) : void
      {
         var _loc2_:IRegionWindow = IRegionWindow(param1.target);
         setUserInfoState(true,_loc2_);
      }
      
      private static function onUserInfoMouseOut(param1:class_1758) : void
      {
         var _loc2_:IRegionWindow = IRegionWindow(param1.target);
         setUserInfoState(false,_loc2_);
      }
      
      public static function setUserInfoState(param1:Boolean, param2:class_1812) : void
      {
         param2.findChildByName("icon_eye_off").visible = !param1;
         param2.findChildByName("icon_eye_over").visible = param1;
      }
      
      public static function onEntry(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_OVER")
         {
            class_2323.setUserInfoState(true,class_1812(param2.parent));
         }
         else if(param1.type == "WME_OUT")
         {
            class_2323.setUserInfoState(false,class_1812(param2.parent));
         }
      }
   }
}

