package com.sulake.habbo.toolbar.memenu
{
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import package_39.class_1884;
   import package_4.class_2005;
   
   public class MeMenuIconLoader implements class_259
   {
      
      private static const MAX_ICON_HEIGHT:int = 50;
      
      private static const HEAD_MARGIN:int = 3;
      
      private var _toolbar:HabboToolbar;
      
      private var var_3007:String;
      
      private var var_2965:BitmapData;
      
      private var var_3345:BitmapData;
      
      private var var_1875:class_2005;
      
      private var var_2100:class_1884;
      
      public function MeMenuIconLoader(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
         var_1875 = new class_2005(onUserObject);
         var_2100 = new class_1884(onUserChange);
         _toolbar.communicationManager.addHabboConnectionMessageEvent(var_1875);
         _toolbar.communicationManager.addHabboConnectionMessageEvent(var_2100);
         setMeMenuToolbarIcon();
      }
      
      private function setMeMenuToolbarIcon(param1:String = null) : void
      {
         var _loc3_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc8_:class_1827 = null;
         var _loc6_:BitmapData = null;
         var _loc9_:BitmapData = null;
         var _loc2_:Rectangle = null;
         if(_toolbar.avatarRenderManager != null)
         {
            _loc7_ = param1 == null ? _toolbar.sessionDataManager.figure : param1;
            if(_loc7_ != var_3007)
            {
               _loc4_ = _toolbar.sessionDataManager.gender;
               _loc8_ = _toolbar.avatarRenderManager.createAvatarImage(_loc7_,"h",_loc4_,this);
               if(_loc8_ != null)
               {
                  _loc8_.setDirection("full",2);
                  _loc3_ = _loc8_.getCroppedImage("full");
                  _loc5_ = _loc8_.getCroppedImage("head");
                  _loc8_.dispose();
               }
               var_3007 = _loc7_;
               if(var_2965 != null)
               {
                  var_2965.dispose();
               }
               var_2965 = _loc3_;
               if(var_3345 != null)
               {
                  var_3345.dispose();
               }
               var_3345 = _loc5_;
            }
            else
            {
               _loc3_ = var_2965;
               _loc5_ = var_3345;
            }
         }
         if(_toolbar != null)
         {
            if(_loc3_ != null && _loc5_ != null)
            {
               if(_loc3_.height > 50)
               {
                  _loc9_ = new BitmapData(_loc3_.width,50,true,0);
                  _loc2_ = _loc9_.rect.clone();
                  if(_loc5_.height > 50 - 3)
                  {
                     _loc2_.offset(0,_loc5_.height - 50 + 3);
                  }
                  _loc9_.copyPixels(_loc3_,_loc2_,new Point(0,0));
                  _loc6_ = _loc9_;
               }
               else
               {
                  _loc6_ = _loc3_.clone();
               }
            }
            _toolbar.setIconBitmap("HTIE_ICON_MEMENU",_loc6_);
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var_3007 = "";
         setMeMenuToolbarIcon();
      }
      
      private function onUserObject(param1:class_2005) : void
      {
         setMeMenuToolbarIcon(param1.getParser().figure);
      }
      
      private function onUserChange(param1:class_1884) : void
      {
         if(param1.id == -1)
         {
            setMeMenuToolbarIcon(param1.figure);
         }
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_1875 != null)
         {
            _toolbar.communicationManager.removeHabboConnectionMessageEvent(var_1875);
            var_1875 = null;
         }
         if(var_2100 != null)
         {
            _toolbar.communicationManager.removeHabboConnectionMessageEvent(var_2100);
            var_2100 = null;
         }
         _toolbar = null;
      }
      
      public function get disposed() : Boolean
      {
         return _toolbar == null;
      }
   }
}

