package com.sulake.habbo.avatar.effects
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.class_2972;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class AvatarEditorGridItemEffect
   {
      
      private var _window:class_1812;
      
      private var var_978:class_1741;
      
      private var var_2281:Boolean = false;
      
      private var var_3766:class_2972;
      
      public function AvatarEditorGridItemEffect(param1:class_2972, param2:class_38, param3:class_40)
      {
         super();
         _window = class_1812(param2.buildFromXML(param3.getAssetByName("avatar_editor_effect_griditem_xml").content as XML));
         var_978 = _window.findChildByTag("BG_COLOR");
         var_3766 = param1;
         if(param1 != null)
         {
            bitmap = param1.icon;
            amount = param1.amountInInventory;
            if(param1.isPermanent)
            {
               setSecondsLeft(param1.duration,param1.duration);
            }
            else if(param1.isActive)
            {
               setSecondsLeft(param1.secondsLeft,param1.duration);
            }
         }
         else
         {
            bitmap = BitmapData(param2.assets.getAssetByName("avatar_editor_generic_remove_selection").content);
            amount = 1;
         }
         selected = false;
         _window.addEventListener("WME_OVER",onMouseOver);
         _window.addEventListener("WME_OUT",onMousetOut);
      }
      
      public function get effectType() : int
      {
         return var_3766 != null ? var_3766.type : -1;
      }
      
      private function onMousetOut(param1:WindowMouseEvent) : void
      {
         if(!var_2281)
         {
            var_978.visible = false;
         }
         var_978.blend = 1;
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         if(!var_2281)
         {
            var_978.visible = true;
            var_978.blend = 0.5;
         }
      }
      
      public function get window() : class_1741
      {
         return _window;
      }
      
      public function set selected(param1:Boolean) : void
      {
         var_2281 = param1;
         var_978.visible = var_2281;
         var_978.blend = 1;
      }
      
      private function set bitmap(param1:BitmapData) : void
      {
         class_2251(_window.findChildByName("bitmap")).bitmap = param1;
      }
      
      private function set amount(param1:int) : void
      {
         var _loc2_:class_1812 = class_1812(_window.findChildByName("effect_amount_bg1"));
         var _loc3_:ITextWindow = ITextWindow(_window.findChildByName("effect_amount"));
         _loc2_.visible = param1 > 1;
         _loc3_.text = param1.toString();
      }
      
      private function setSecondsLeft(param1:int, param2:int) : void
      {
         _window.findChildByName("duration_container").visible = true;
         var _loc5_:class_2251 = class_2251(_window.findChildByName("progress_bar"));
         var _loc3_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,false,0);
         var _loc4_:Rectangle = new Rectangle(0,0,int(_loc3_.width * (param1 / param2)),_loc3_.height);
         _loc3_.fillRect(_loc4_,2146080);
         _loc5_.bitmap = _loc3_;
      }
   }
}

