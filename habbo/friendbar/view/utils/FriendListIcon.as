package com.sulake.habbo.friendbar.view.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.components.class_2251;
   import flash.events.TimerEvent;
   
   public class FriendListIcon extends Icon
   {
      
      private static const const_381:int = 200;
      
      private static const NOTIFY_DELAY:int = 500;
      
      private var _assets:class_40;
      
      public function FriendListIcon(param1:class_40, param2:class_2251)
      {
         super();
         _assets = param1;
         alignment = 1 | 8;
         image = param1.getAssetByName("icon_friendlist_png") as BitmapDataAsset;
         canvas = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            _assets = null;
            super.dispose();
         }
      }
      
      override public function notify(param1:Boolean) : void
      {
         super.notify(param1);
         enable(param1);
         toggleTimer(param1 || _hover,_hover ? 200 : 500);
         if(!var_1721 && !_hover)
         {
            image = _assets.getAssetByName("icon_friendlist_png") as BitmapDataAsset;
         }
      }
      
      override public function hover(param1:Boolean) : void
      {
         super.hover(param1);
         toggleTimer(param1 || var_1721,_hover ? 200 : 500);
         if(!var_1721 && !_hover)
         {
            image = _assets.getAssetByName("icon_friendlist_png") as BitmapDataAsset;
         }
      }
      
      override public function enable(param1:Boolean) : void
      {
         canvas.blend = disabled ? 0.5 : 1;
      }
      
      override protected function onTimerEvent(param1:TimerEvent) : void
      {
         if(_hover)
         {
            _frame = ++_frame % 4;
            image = _assets.getAssetByName("icon_friendlist_hover_" + _frame + "_png") as BitmapDataAsset;
         }
         else if(var_1721)
         {
            _frame = ++_frame % 2;
            image = _assets.getAssetByName("icon_friendlist_notify_" + _frame + "_png") as BitmapDataAsset;
         }
      }
   }
}

