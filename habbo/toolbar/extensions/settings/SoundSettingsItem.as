package com.sulake.habbo.toolbar.extensions.settings
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.toolbar.memenu.soundsettings.MeMenuSoundSettingsSlider;
   
   public class SoundSettingsItem implements class_13
   {
      
      public static const TYPE_UI_VOLUME:int = 0;
      
      public static const TYPE_FURNI_VOLUME:int = 1;
      
      public static const TYPE_TRAX_VOLUME:int = 2;
      
      private var var_230:int;
      
      private var _volume:Number;
      
      private var _window:class_1812;
      
      private var var_1174:MeMenuSoundSettingsSlider;
      
      private var var_508:SoundSettingsView;
      
      public function SoundSettingsItem(param1:SoundSettingsView, param2:int, param3:class_1812)
      {
         super();
         var_230 = param2;
         var_508 = param1;
         _window = param3;
         var_1174 = new MeMenuSoundSettingsSlider(this,_window.findChildByName("volume_container") as class_1812,param1.toolbar.assets,0,1);
         var _loc4_:class_1741 = _window.findChildByName("sounds_off");
         if(_loc4_ != null)
         {
            null.addEventListener("WME_CLICK",onButtonClicked);
         }
         _loc4_ = _window.findChildByName("sounds_on");
         if(_loc4_ != null)
         {
            null.addEventListener("WME_CLICK",onButtonClicked);
         }
         updateSoundIcons();
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_1174)
            {
               var_1174.dispose();
               var_1174 = null;
            }
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_508 == null;
      }
      
      public function saveVolume(param1:Number, param2:Boolean) : void
      {
         _volume = param1;
         switch(var_230)
         {
            case 0:
               var_508.saveVolume(param1,-1,-1,param2);
               break;
            case 1:
               var_508.saveVolume(-1,param1,-1,param2);
               break;
            case 2:
               var_508.saveVolume(-1,-1,param1,param2);
         }
         updateSoundIcons();
         var_508.updateSettings();
      }
      
      private function updateSoundIcons() : void
      {
         if(_volume == 0)
         {
            setBitmap("sounds_on_icon","sounds_on_white");
            setBitmap("sounds_off_icon","sounds_off_color");
         }
         else
         {
            setBitmap("sounds_on_icon","sounds_on_color");
            setBitmap("sounds_off_icon","sounds_off_white");
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "sounds_off":
               saveVolume(0,false);
               break;
            case "sounds_on":
               saveVolume(1,false);
               break;
            default:
               class_21.log("Me Menu Settings, Sound settings item: unknown button: " + _loc3_);
         }
      }
      
      private function setBitmap(param1:String, param2:String) : void
      {
         IStaticBitmapWrapperWindow(_window.findChildByName(param1)).assetUri = "toolbar_memenu_settings_" + param2;
      }
      
      public function setValue(param1:Number) : void
      {
         var_1174.setValue(param1);
         updateSoundIcons();
      }
   }
}

