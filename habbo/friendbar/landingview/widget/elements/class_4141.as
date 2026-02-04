package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class class_4141 implements IElementHandler, class_13
   {
      
      private var _landingView:HabboLandingView;
      
      private var var_989:String;
      
      public function class_4141()
      {
         super();
      }
      
      public function dispose() : void
      {
         _landingView = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         _landingView = param1;
         var _loc5_:String = param3[1];
         var_989 = param3[2];
         param2.procedure = onLink;
         class_1812(param2).findChildByName("link_txt").caption = "${" + _loc5_ + "}";
      }
      
      private function onLink(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,null);
            HabboWebTools.openWebPage(var_989);
            _landingView.tracking.trackGoogle("landingView","click_link");
         }
      }
      
      public function refresh() : void
      {
      }
   }
}

