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
   
   public class PlayListEditorItem
   {
      
      public static const ICON_STATE_NORMAL:String = "PLEI_ICON_STATE_NORMAL";
      
      public static const ICON_STATE_PLAYING:String = "PLEI_ICON_STATE_PLAYING";
      
      private static const BG_COLOR_SELECTED:uint = 14283002;
      
      private static const BG_COLOR_UNSELECTED:uint = 15856113;
      
      private var var_16:PlayListEditorWidget;
      
      private var _window:class_1812;
      
      private var var_4344:class_2143 = null;
      
      private var var_859:ColorTransform;
      
      public function PlayListEditorItem(param1:PlayListEditorWidget, param2:String, param3:String, param4:ColorTransform)
      {
         super();
         var_16 = param1;
         var_859 = param4;
         createWindow();
         setIconState("PLEI_ICON_STATE_NORMAL");
         deselect();
         trackName = param2;
         trackAuthor = param3;
         diskColor = param4;
      }
      
      public function get window() : class_1741
      {
         return _window as class_1741;
      }
      
      public function get removeButton() : class_2143
      {
         return var_4344;
      }
      
      private function createWindow() : void
      {
         if(var_16 == null)
         {
            return;
         }
         var _loc2_:XmlAsset = var_16.assets.getAssetByName("playlisteditor_playlist_item") as XmlAsset;
         _window = var_16.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc3_:BitmapDataAsset = var_16.assets.getAssetByName("icon_arrow_left") as BitmapDataAsset;
         assignAssetByNameToElement("jb_icon_disc",_window.getChildByName("song_name_icon_bitmap") as class_2251);
         assignAssetByNameToElement("jb_icon_composer",_window.getChildByName("author_name_icon_bitmap") as class_2251);
         var _loc1_:class_1812 = _window.getChildByName("action_buttons") as class_1812;
         if(_loc1_ != null)
         {
            _loc1_ = _loc1_.getChildByName("button_border") as class_1812;
            if(_loc1_ != null)
            {
               var_4344 = _loc1_.getChildByName("button_remove_from_playlist") as class_2143;
            }
         }
      }
      
      public function select() : void
      {
         var _loc2_:class_1993 = _window.getChildByName("background") as class_1993;
         if(_loc2_ != null)
         {
            _loc2_.color = 14283002;
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
      
      public function setIconState(param1:String) : void
      {
         var _loc3_:BitmapDataAsset = null;
         var _loc2_:BitmapData = null;
         switch(param1)
         {
            case "PLEI_ICON_STATE_NORMAL":
               diskColor = var_859;
               break;
            case "PLEI_ICON_STATE_PLAYING":
               _loc3_ = var_16.assets.getAssetByName("icon_notes_small") as BitmapDataAsset;
               if(_loc3_ == null)
               {
                  return;
               }
               if(_loc3_.content != null)
               {
                  _loc2_ = _loc3_.content as BitmapData;
                  this.diskIconBitmap = _loc2_.clone();
               }
         }
      }
      
      public function set diskColor(param1:ColorTransform) : void
      {
         var _loc2_:BitmapData = null;
         var _loc4_:BitmapData = null;
         var _loc3_:BitmapDataAsset = var_16.assets.getAssetByName("icon_cd_small") as BitmapDataAsset;
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
      
      public function set trackName(param1:String) : void
      {
         var _loc2_:ITextWindow = _window.getChildByName("song_title_text") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.text = param1;
         }
      }
      
      public function set trackAuthor(param1:String) : void
      {
         var _loc2_:ITextWindow = _window.getChildByName("song_author_text") as ITextWindow;
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
      
      private function set buttonRemoveBitmap(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1812 = _window.getChildByName("action_buttons") as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_ = _loc2_.getChildByName("button_border") as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_ = _loc2_.getChildByName("button_remove_from_playlist") as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:class_2251 = _loc2_.getChildByName("button_remove_from_playlist_image") as class_2251;
         if(_loc3_ != null)
         {
            _loc3_.bitmap = param1.clone();
            _loc3_.width = param1.width;
            _loc3_.height = param1.height;
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

