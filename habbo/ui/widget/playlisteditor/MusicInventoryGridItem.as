package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2143;
   import com.sulake.core.window.components.class_2251;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   
   public class MusicInventoryGridItem
   {
      
      public static const const_932:int = 0;
      
      public static const const_407:int = 1;
      
      public static const BUTTON_STATE_DOWNLOAD:int = 2;
      
      private static const BG_COLOR_SELECTED:uint = 14612159;
      
      private static const BG_COLOR_UNSELECTED:uint = 15856113;
      
      private var var_16:PlayListEditorWidget;
      
      private var _window:class_1812 = null;
      
      private var var_4914:int;
      
      private var var_2766:int;
      
      private var var_4799:class_2143 = null;
      
      private var var_4927:int;
      
      public function MusicInventoryGridItem(param1:PlayListEditorWidget, param2:int, param3:int, param4:String, param5:ColorTransform)
      {
         super();
         var_16 = param1;
         var_4914 = param2;
         var_2766 = param3;
         createWindow();
         deselect();
         if(param4 != null && param5 != null)
         {
            trackName = param4;
            diskColor = param5;
         }
      }
      
      public function get window() : class_1741
      {
         return _window as class_1741;
      }
      
      public function get diskId() : int
      {
         return var_4914;
      }
      
      public function get songId() : int
      {
         return var_2766;
      }
      
      public function get toPlayListButton() : class_2143
      {
         return var_4799;
      }
      
      public function get playButtonState() : int
      {
         return var_4927;
      }
      
      public function update(param1:int, param2:String, param3:ColorTransform) : void
      {
         if(param1 == var_2766)
         {
            trackName = param2;
            diskColor = param3;
         }
      }
      
      public function destroy() : void
      {
         if(_window)
         {
            _window.destroy();
         }
      }
      
      private function createWindow() : void
      {
         if(var_16 == null)
         {
            return;
         }
         var _loc2_:XmlAsset = var_16.assets.getAssetByName("playlisteditor_music_inventory_item") as XmlAsset;
         _window = var_16.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc1_:class_1812 = _window.getChildByName("action_buttons") as class_1812;
         if(_loc1_ != null)
         {
            var_4799 = _loc1_.getChildByName("button_to_playlist") as class_2143;
         }
         assignAssetByNameToElement("title_fader",_window.getChildByName("title_fader_bitmap") as class_2251);
         var _loc3_:BitmapDataAsset = var_16.assets.getAssetByName("icon_arrow") as BitmapDataAsset;
         this.playButtonState = 0;
      }
      
      public function select() : void
      {
         var _loc2_:class_1993 = _window.getChildByName("background") as class_1993;
         if(_loc2_ != null)
         {
            _loc2_.color = 14612159;
         }
         var _loc3_:class_1812 = _window.getChildByName("action_buttons") as class_1812;
         if(_loc3_ != null)
         {
            _loc3_.visible = true;
         }
         var _loc1_:class_1993 = _window.getChildByName("selected") as class_1993;
         if(_loc1_ != null)
         {
            _loc1_.visible = true;
         }
      }
      
      public function deselect() : void
      {
         var _loc2_:class_1993 = _window.getChildByName("background") as class_1993;
         if(_loc2_ != null)
         {
            _loc2_.color = 15856113;
         }
         var _loc3_:class_1812 = _window.getChildByName("action_buttons") as class_1812;
         if(_loc3_ != null)
         {
            _loc3_.visible = false;
         }
         var _loc1_:class_1993 = _window.getChildByName("selected") as class_1993;
         if(_loc1_ != null)
         {
            _loc1_.visible = false;
         }
      }
      
      public function set diskColor(param1:ColorTransform) : void
      {
         var _loc2_:BitmapData = null;
         var _loc4_:BitmapData = null;
         var _loc3_:BitmapDataAsset = var_16.assets.getAssetByName("icon_cd_big") as BitmapDataAsset;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.content != null)
         {
            _loc2_ = _loc3_.content as BitmapData;
            _loc4_ = _loc2_.clone();
            if(_loc4_ != null)
            {
               _loc4_.colorTransform(_loc2_.rect,param1);
               this.diskIconBitmap = _loc4_;
            }
         }
      }
      
      public function set playButtonState(param1:int) : void
      {
         var _loc2_:BitmapDataAsset = null;
         if(param1 == 0)
         {
            _loc2_ = var_16.assets.getAssetByName("icon_play") as BitmapDataAsset;
         }
         else if(param1 == 1)
         {
            _loc2_ = var_16.assets.getAssetByName("icon_pause") as BitmapDataAsset;
         }
         else if(param1 == 2)
         {
            _loc2_ = var_16.assets.getAssetByName("icon_download") as BitmapDataAsset;
         }
         if(_loc2_ != null)
         {
            if(_loc2_.content != null)
            {
               this.buttonPlayPauseBitmap = _loc2_.content as BitmapData;
            }
         }
         var_4927 = param1;
      }
      
      public function set trackName(param1:String) : void
      {
         var _loc2_:ITextWindow = _window.getChildByName("song_title_text") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.text = param1;
         }
      }
      
      private function set diskIconBitmap(param1:BitmapData) : void
      {
         var _loc2_:class_2251 = _window.getChildByName("disk_image") as class_2251;
         if(_loc2_ != null)
         {
            _loc2_.bitmap = param1;
         }
      }
      
      private function set buttonToPlaylistBitmap(param1:BitmapData) : void
      {
         assignBitmapDataToButton("button_to_playlist","image_button_to_playlist",param1);
      }
      
      private function set buttonPlayPauseBitmap(param1:BitmapData) : void
      {
         assignBitmapDataToButton("button_play_pause","image_button_play_pause",param1);
      }
      
      private function assignBitmapDataToButton(param1:String, param2:String, param3:BitmapData) : void
      {
         if(param3 == null)
         {
            return;
         }
         var _loc4_:class_1812 = _window.getChildByName("action_buttons") as class_1812;
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_ = _loc4_.getChildByName(param1) as class_1812;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:class_2251 = _loc4_.getChildByName(param2) as class_2251;
         if(_loc5_ != null)
         {
            _loc5_.bitmap = param3.clone();
            _loc5_.width = param3.width;
            _loc5_.height = param3.height;
         }
      }
      
      private function assignAssetByNameToElement(param1:String, param2:class_2251) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapDataAsset = var_16.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc4_ != null)
         {
            if(param2 != null && _loc4_.content != null)
            {
               _loc3_ = _loc4_.content as BitmapData;
               param2.bitmap = _loc3_.clone();
            }
         }
      }
   }
}

