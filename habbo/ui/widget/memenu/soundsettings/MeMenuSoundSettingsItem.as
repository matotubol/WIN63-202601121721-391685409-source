package com.sulake.habbo.ui.widget.memenu.soundsettings
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   
   public class MeMenuSoundSettingsItem implements class_13
   {
      
      public static const TYPE_UI_VOLUME:int = 0;
      
      public static const TYPE_FURNI_VOLUME:int = 1;
      
      public static const TYPE_TRAX_VOLUME:int = 2;
      
      private var var_230:int;
      
      private var _volume:Number;
      
      private var _window:class_1812;
      
      private var var_1174:MeMenuSoundSettingsSlider;
      
      private var var_508:MeMenuSoundSettingsView;
      
      public function MeMenuSoundSettingsItem(param1:MeMenuSoundSettingsView, param2:int, param3:class_1812)
      {
         super();
         var_230 = param2;
         var_508 = param1;
         _window = param3;
         var_1174 = new MeMenuSoundSettingsSlider(this,_window.findChildByName("volume_container") as class_1812,var_508.widget.assets,0,1);
         var _loc4_:class_1741 = _window.findChildByName("sounds_off");
         if(_loc4_ != null)
         {
            null.addEventListener("WME_CLICK",onButtonClicked);
            null.addEventListener("WME_OVER",onButtonOver);
            null.addEventListener("WME_OUT",onButtonOut);
         }
         _loc4_ = _window.findChildByName("sounds_on");
         if(_loc4_ != null)
         {
            null.addEventListener("WME_CLICK",onButtonClicked);
            null.addEventListener("WME_OVER",onButtonOver);
            null.addEventListener("WME_OUT",onButtonOut);
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
      }
      
      private function updateSoundIcons() : void
      {
         if(_volume == 0)
         {
            setBitmapWrapperContent("sounds_on_icon",var_508.soundsOnIconWhite);
            setBitmapWrapperContent("sounds_off_icon",var_508.soundsOffIconColor);
         }
         else
         {
            setBitmapWrapperContent("sounds_on_icon",var_508.soundsOnIconColor);
            setBitmapWrapperContent("sounds_off_icon",var_508.soundsOffIconWhite);
         }
      }
      
      private function onButtonOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "sounds_off_icon":
            case "sounds_off":
               setBitmapWrapperContent("sounds_off_icon",var_508.soundsOffIconColor);
               break;
            case "sounds_on_icon":
            case "sounds_on":
               setBitmapWrapperContent("sounds_on_icon",var_508.soundsOnIconColor);
         }
      }
      
      private function onButtonOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "sounds_off":
               if(_volume != 0)
               {
                  setBitmapWrapperContent("sounds_off_icon",var_508.soundsOffIconWhite);
               }
               break;
            case "sounds_on":
               if(_volume != 1)
               {
                  setBitmapWrapperContent("sounds_on_icon",var_508.soundsOnIconWhite);
               }
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
      
      private function setBitmapWrapperContent(param1:String, param2:BitmapData) : void
      {
         var _loc3_:class_2251 = _window.findChildByName(param1) as class_2251;
         if(_loc3_ != null && param2 != null)
         {
            _loc3_.bitmap = param2.clone();
         }
      }
      
      public function setValue(param1:Number) : void
      {
         var_1174.setValue(param1);
         updateSoundIcons();
      }
   }
}

