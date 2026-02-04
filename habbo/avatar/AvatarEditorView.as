package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.common.class_3455;
   import com.sulake.habbo.avatar.view.AvatarEditorNameChangeView;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class AvatarEditorView
   {
      
      public static var THUMB_WINDOW:class_1812;
      
      public static var COLOUR_WINDOW:class_1812;
      
      public static var TAB_BACKGROUND_COLOUR:int = 6710886;
      
      private static const SAVE_TIMEOUT_MS:int = 1500;
      
      private static const DEFAULT_LOCATION:Point = new Point(100,30);
      
      private var var_45:HabboAvatarEditor;
      
      private var var_51:class_1812;
      
      private var var_2994:String;
      
      private var var_419:ITabContextWindow;
      
      private var var_130:class_2250;
      
      private var var_1050:class_1812;
      
      private var var_786:Timer;
      
      private var var_1822:int = 4;
      
      private var var_2889:String;
      
      private var _showWardrobeOnUpdate:Boolean = true;
      
      private var var_2218:Array = [];
      
      private var var_1719:Array = ["generic","head","torso","legs","hotlooks","wardrobe","nfts"];
      
      private var _categoryContainers:Dictionary;
      
      private var var_237:class_3455;
      
      private var var_4622:class_3455;
      
      private var var_3334:AvatarEditorNameChangeView;
      
      public function AvatarEditorView(param1:HabboAvatarEditor, param2:Array)
      {
         super();
         var_45 = param1;
         var_786 = new Timer(1500,1);
         var_786.addEventListener("timer",onUpdate);
         if(param1.manager.getBoolean("effects.in.avatar.editor"))
         {
            var_1719.push("effects");
         }
         if(param2 == null)
         {
            param2 = var_1719;
         }
         for each(var _loc3_ in param2)
         {
            var_2218.push(_loc3_);
         }
         createWindow();
      }
      
      public function dispose() : void
      {
         var _loc3_:class_1812 = null;
         var _loc2_:class_1812 = null;
         var _loc1_:class_1812 = null;
         if(var_786 != null)
         {
            var_786.stop();
            var_786.removeEventListener("timer",onUpdate);
            var_786 = null;
         }
         if(var_419)
         {
            var_419.dispose();
            var_419 = null;
         }
         if(var_51)
         {
            var_51.dispose();
            var_51 = null;
         }
         if(var_1050 != null)
         {
            var_1050.dispose();
            var_1050 = null;
         }
         if(var_130)
         {
            var_130.dispose();
            var_130 = null;
         }
         if(var_51 != null)
         {
            _loc3_ = var_51.findChildByName("figureContainer") as class_1812;
            if(_loc3_ != null)
            {
               while(_loc3_.numChildren > 0)
               {
                  _loc3_.removeChildAt(0);
               }
            }
            _loc2_ = var_51.findChildByName("contentArea") as class_1812;
            if(_loc2_ != null)
            {
               while(_loc2_.numChildren > 0)
               {
                  _loc2_.removeChildAt(0);
               }
            }
            _loc1_ = var_51.findChildByName("sideContainer") as class_1812;
            if(_loc1_ != null)
            {
               while(_loc1_.numChildren > 0)
               {
                  _loc1_.removeChildAt(0);
               }
            }
            var_45 = null;
         }
      }
      
      public function getFrame(param1:Array, param2:String = null) : class_2250
      {
         if(var_130)
         {
            var_130.visible = true;
            var_130.activate();
            return var_130;
         }
         if(var_130)
         {
            var_130.dispose();
            var_130 = null;
         }
         var _loc3_:XmlAsset = var_45.manager.assets.getAssetByName("AvatarEditorFrame") as XmlAsset;
         if(_loc3_)
         {
            var_130 = var_45.manager.windowManager.buildFromXML(_loc3_.content as XML) as class_2250;
         }
         if(var_130 == null)
         {
            return null;
         }
         var _loc4_:class_1812 = var_130.findChildByName("maincontent") as class_1812;
         if(!embedToContext(_loc4_,param1))
         {
            var_130.dispose();
            var_130 = null;
            return null;
         }
         if(param2 && var_130.header != null)
         {
            var_130.header.title.text = param2;
         }
         var_130.position = DEFAULT_LOCATION;
         var_130.findChildByName("header_button_close").procedure = windowEventProc;
         return var_130;
      }
      
      public function embedToContext(param1:class_1812, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         if(!validateAvailableCategories(param2))
         {
            return false;
         }
         if(param1)
         {
            _loc3_ = int(param1.getChildIndex(var_51));
            if(_loc3_)
            {
               param1.removeChildAt(_loc3_);
            }
            param1.addChild(var_51);
         }
         else
         {
            if(var_1050 == null)
            {
               var_1050 = var_45.manager.windowManager.createWindow("avatarEditorContainer","",4,3,0x020000 | 1,new Rectangle(0,0,2,2),null,0) as class_1812;
               var_1050.addChild(var_51);
            }
            _loc3_ = int(var_1050.getChildIndex(var_51));
            if(_loc3_)
            {
               param1.removeChildAt(_loc3_);
            }
            var_1050.visible = true;
         }
         return true;
      }
      
      public function validateAvailableCategories(param1:Array) : Boolean
      {
         if(param1 == null)
         {
            return validateAvailableCategories(var_1719);
         }
         if(param1.length != var_2218.length)
         {
            return false;
         }
         for each(var _loc2_ in param1)
         {
            if(var_2218.indexOf(_loc2_) < 0)
            {
               return false;
            }
         }
         return true;
      }
      
      private function onUpdate(param1:Event = null) : void
      {
         var_786.stop();
         if(var_51)
         {
            var_51.findChildByName("save").enable();
         }
      }
      
      public function show() : void
      {
         if(var_130)
         {
            var_130.visible = true;
         }
         else if(var_51)
         {
            var_51.visible = true;
         }
      }
      
      public function hide() : void
      {
         if(var_130)
         {
            var_130.visible = false;
         }
         else if(var_51)
         {
            var_51.visible = false;
         }
      }
      
      private function createWindow() : void
      {
         if(var_51 == null)
         {
            var_51 = var_45.manager.windowManager.buildFromXML((var_45.manager.assets.getAssetByName("AvatarEditorContent") as XmlAsset).content as XML) as class_1812;
         }
         if(THUMB_WINDOW == null)
         {
            THUMB_WINDOW = var_51.findChildByName("thumb_template") as class_1812;
            if(THUMB_WINDOW)
            {
               var_51.removeChild(THUMB_WINDOW);
            }
         }
         if(COLOUR_WINDOW == null)
         {
            COLOUR_WINDOW = var_51.findChildByName("palette_template") as class_1812;
            if(COLOUR_WINDOW)
            {
               var_51.removeChild(COLOUR_WINDOW);
            }
         }
         if(var_45.manager != null && var_45.manager.sessionData != null)
         {
            var_51.findChildByName("avatar_name").caption = var_45.manager.sessionData.userName;
            if(var_45.manager.getBoolean("premium.name.change.enabled"))
            {
               var_51.findChildByName("avatar_name_change").visible = true;
            }
         }
         var_51.procedure = windowEventProc;
         var_419 = var_51.findChildByName("mainTabs") as ITabContextWindow;
         var _loc1_:Vector.<String> = new Vector.<String>(0);
         var _loc4_:int = var_419.numTabItems - 1;
         while(true)
         {
            var _loc3_:ITabButtonWindow = var_419.getTabItemAt(0);
            _loc1_.push(null.name);
            _loc4_--;
         }
      }
      
      public function update() : void
      {
         var _loc1_:class_1741 = var_51.findChildByName("wardrobeButtonContainer") as class_1741;
         if(_loc1_ && var_45.manager.sessionData)
         {
            _loc1_.visible = var_45.manager.sessionData.hasClub && var_45.isSideContentEnabled();
            _loc1_.visible = var_45.isSideContentEnabled();
         }
         var _loc2_:String = "nothing";
         if(var_2889 == "wardrobe" || _showWardrobeOnUpdate)
         {
            _loc2_ = "wardrobe";
         }
         if(!var_45.isSideContentEnabled())
         {
            _loc2_ = "nothing";
         }
         if(var_45.hasInvalidClubItems())
         {
            var_45.stripClubItems();
            var_45.disableClubClothing();
         }
         if(var_45.hasInvalidSellableItems())
         {
            var_45.stripInvalidSellableItems();
         }
         setSideContent(_loc2_);
         setViewToCategory(var_2994);
      }
      
      public function toggleCategoryView(param1:String, param2:Boolean = false) : void
      {
         if(param2)
         {
         }
         setViewToCategory(param1);
      }
      
      private function toggleWardrobe() : void
      {
         if(var_2889 == "wardrobe")
         {
            _showWardrobeOnUpdate = false;
            setSideContent("nothing");
         }
         else
         {
            setSideContent("wardrobe");
         }
      }
      
      private function setSideContent(param1:String) : void
      {
         if(var_2889 == param1)
         {
            return;
         }
         var _loc2_:class_1812 = var_51.findChildByName("sideContainer") as class_1812;
         if(!_loc2_)
         {
            return;
         }
         switch(param1)
         {
            case "wardrobe":
               var _loc4_:class_1741 = var_45.getSideContentWindowContainer("wardrobe");
               break;
            case "nothing":
         }
         var _loc3_:class_1741 = _loc2_.removeChildAt(0);
         if(_loc3_)
         {
            var_51.width -= _loc3_.width;
         }
         _loc2_.width = 0;
         var_2889 = param1;
         if(var_130)
         {
            var _loc5_:int = 8;
            var_130.content.width = var_51.width + 0;
         }
      }
      
      private function setViewToCategory(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         var _loc2_:class_1812 = var_51.findChildByName("contentArea") as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         effectsParamViewContainer.visible = param1 == "effects";
         collectiblesAvatarInfoContainer.visible = false;
         if("nfts" == param1)
         {
            _showWardrobeOnUpdate = false;
            var_51.findChildByName("wardrobe").disable();
            setSideContent("nothing");
         }
         else
         {
            var_51.findChildByName("wardrobe").enable();
         }
         var _loc4_:class_1741 = _loc2_.getChildAt(0);
         _loc2_.removeChild(_loc4_);
         _loc2_.invalidate();
         var _loc3_:class_1741 = var_45.getCategoryWindowContainer(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var_237.window.visible = false;
         _loc3_.visible = true;
         _loc2_.addChild(_loc3_);
         var_45.activateCategory(param1);
         var_2994 = param1;
         var_419.selector.setSelected(var_419.getTabItemByName(param1));
      }
      
      public function windowEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:String = null;
         var _loc6_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(param1.type == "WE_SELECTED")
         {
            _loc3_ = (param2 as ITabContextWindow).selector.getSelected().name;
            if(_loc3_ != var_2994)
            {
               _loc6_ = false;
               _loc4_ = false;
               _loc5_ = false;
               if(_loc3_ != "effects" && _loc3_ != "hotlooks")
               {
                  while(true)
                  {
                     if(var_45.hasNftOutfit() && "nfts" == _loc3_)
                     {
                        _loc5_ = true;
                     }
                     else if(var_45.hasNftOutfit() && _loc3_ != "nfts")
                     {
                        _loc6_ = true;
                     }
                     else if(editor.hasSetNftOutfitInViewer() && _loc3_ != "nfts")
                     {
                        _loc4_ = true;
                     }
                  }
                  §§goto(addr028b);
               }
               if(var_45.hasNftOutfit() && _loc3_ == "effects")
               {
                  _loc5_ = true;
               }
               var_45.toggleAvatarEditorPage(_loc3_);
               if(_loc6_)
               {
                  var_45.loadFallbackFigure();
               }
               else if(_loc4_)
               {
                  var_45.loadRollbackFigure();
               }
               else if(_loc5_)
               {
                  var_45.loadNftFigure();
               }
            }
         }
         else if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "save":
                  if(!var_45.isDevelopmentEditor() && var_45.hasInvalidSellableItems())
                  {
                     startSellablePurchase();
                     var_786.start();
                     var_51.findChildByName("save").disable();
                     return;
                  }
                  if(!var_45.isDevelopmentEditor() && var_45.hasInvalidClubItems())
                  {
                     var_45.openHabboClubAdWindow();
                     var_786.start();
                     var_51.findChildByName("save").disable();
                     return;
                  }
                  var_786.start();
                  var_51.findChildByName("save").disable();
                  var_45.saveCurrentSelection();
                  var_45.manager.close(var_45.instanceId);
                  break;
               case "cancel":
               case "header_button_close":
                  if(var_45.hasInvalidClubItems())
                  {
                     var_45.stripClubItems();
                     var_45.disableClubClothing();
                  }
                  var_45.manager.close(var_45.instanceId);
                  break;
               case "rotate_avatar":
                  var_1822 = var_1822 + 1;
                  if(var_1822 > 7)
                  {
                     var_1822 = 0;
                  }
                  var_45.figureData.direction = var_1822;
                  break;
               case "wardrobe":
                  toggleWardrobe();
                  break;
               case "avatar_name_change":
                  if(var_3334 != null)
                  {
                     var_3334.focus();
                     break;
                  }
                  var_3334 = new AvatarEditorNameChangeView(this,var_51.x + var_51.width,var_51.y);
            }
         }
         addr028b:
      }
      
      private function startSellablePurchase() : void
      {
         if(var_45.manager.catalog)
         {
            var_45.manager.catalog.openCatalogPage(var_45.manager.getProperty("catalog.clothes.page"));
         }
      }
      
      public function get effectsParamViewContainer() : class_1812
      {
         return class_1812(var_51.findChildByName("effectParamsContainer"));
      }
      
      public function get collectiblesAvatarInfoContainer() : class_1812
      {
         return class_1812(var_51.findChildByName("collectible_avatar_info"));
      }
      
      public function getCategoryContainer(param1:String) : class_1741
      {
         return _categoryContainers[param1];
      }
      
      public function get gridView() : class_3455
      {
         return var_237;
      }
      
      public function getFigureContainer() : class_2010
      {
         return var_51.findChildByName("avatarWidget") as class_2010;
      }
      
      public function get effectsGridView() : class_3455
      {
         return var_4622;
      }
      
      public function get editor() : HabboAvatarEditor
      {
         return var_45;
      }
      
      public function get avatarEditorNameChangeView() : AvatarEditorNameChangeView
      {
         return var_3334;
      }
      
      public function get currentViewId() : String
      {
         return var_2994;
      }
   }
}

