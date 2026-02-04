package com.sulake.habbo.friendbar.popup
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.friendbar.class_1847;
   import com.sulake.habbo.friendbar.view.AbstractView;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import package_62.class_2900;
   
   public class HabboEpicPopupView extends AbstractView implements class_1847
   {
      
      private var _communicationManager:class_57;
      
      private var _activeFrame:class_1812;
      
      public function HabboEpicPopupView(param1:class_15, param2:uint, param3:class_40)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         })]);
      }
      
      override public function dispose() : void
      {
         if(_activeFrame != null)
         {
            _activeFrame.dispose();
            _activeFrame = null;
         }
         super.dispose();
      }
      
      override protected function initComponent() : void
      {
         _communicationManager.addHabboConnectionMessageEvent(new class_2900(onEpicPopupMessageEvent));
      }
      
      private function onEpicPopupMessageEvent(param1:class_2900) : void
      {
         showPopup(param1.getParser().imageUri);
      }
      
      public function showPopup(param1:String) : void
      {
         if(_activeFrame != null)
         {
            _activeFrame.dispose();
         }
         _activeFrame = _windowManager.buildFromXML(assets.getAssetByName("epic_popup_frame_xml").content as XML) as class_1812;
         IStaticBitmapWrapperWindow(_activeFrame.findChildByName("content_static_bitmap")).assetUri = param1;
         _activeFrame.procedure = windowProc;
         _activeFrame.center();
      }
      
      private function windowProc(param1:class_1758, param2:class_1741) : void
      {
         if(_activeFrame != null && param1.type == "WME_CLICK")
         {
            switch(param1.target.name)
            {
               case "close_button":
               case "header_button_close":
                  _activeFrame.dispose();
                  _activeFrame = null;
            }
         }
      }
   }
}

