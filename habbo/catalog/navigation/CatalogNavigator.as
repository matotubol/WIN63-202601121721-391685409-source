package com.sulake.habbo.catalog.navigation
{
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.TopViewSelector;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.catalog.navigation.events.CatalogPageOpenedEvent;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2971;
   
   public class CatalogNavigator implements class_1737
   {
      
      public static const DUMMY_PAGE_ID_FOR_OFFER_SEARCH:int = -12345678;
      
      private var _catalog:HabboCatalog;
      
      private var _container:class_1812;
      
      private var var_327:String;
      
      private var var_817:ITabContextWindow;
      
      private var var_121:IItemListWindow;
      
      private var _index:class_1917;
      
      private var var_416:Vector.<class_1917>;
      
      private var _offersToNodes:Dictionary;
      
      private var var_3426:class_1741;
      
      private var var_3625:class_1741;
      
      private var var_4067:class_1741;
      
      private var var_1416:TopViewSelector;
      
      public function CatalogNavigator(param1:HabboCatalog, param2:class_1812, param3:String)
      {
         super();
         _catalog = param1;
         _container = param2;
         var_327 = param3;
         var_416 = new Vector.<class_1917>(0);
         var_121 = _container.findChildByName("navigationList") as IItemListWindow;
         var_3426 = var_121.removeListItem(var_121.getListItemByName(param3.toLowerCase() + "_topitem_template"));
         var_3625 = var_121.removeListItem(var_121.getListItemByName(param3.toLowerCase() + "_subitem_template"));
         var_4067 = var_121.removeListItem(var_121.getListItemByName(param3.toLowerCase() + "_list_template"));
         var_817 = ITabContextWindow(_container.findChildByName("tab_context"));
         if(var_817 != null)
         {
            if(_catalog.useNonTabbedCatalog())
            {
               var_817.visible = false;
            }
            else
            {
               var_1416 = new TopViewSelector(this,var_817);
            }
         }
      }
      
      private static function searchNodesWith(param1:String, param2:Array, param3:class_1917, param4:Vector.<class_1917>) : void
      {
         var _loc6_:Boolean = false;
         var _loc5_:String = null;
         try
         {
            if(param3.visible && param3.pageId > 0)
            {
               _loc6_ = false;
               _loc5_ = [param3.pageName,param3.localization].join(" ").toLowerCase();
               _loc5_ = _loc5_.replace(/ /gi,"");
               if(_loc5_.indexOf(param1) > -1)
               {
                  param4.push(param3);
                  _loc6_ = true;
               }
               if(!_loc6_)
               {
                  for each(var _loc7_ in param2)
                  {
                     if(_loc5_.indexOf(_loc7_) >= 0)
                     {
                        param4.push(param3);
                        break;
                     }
                  }
               }
            }
            for each(var _loc8_ in param3.children)
            {
               searchNodesWith(param1,param2,_loc8_,param4);
            }
         }
         catch(e:Error)
         {
            class_21.log("Error when loading nodes by name " + param1 + ":",e);
         }
      }
      
      public function get initialized() : Boolean
      {
         return _index != null;
      }
      
      public function dispose() : void
      {
         if(_index != null)
         {
            _index.dispose();
         }
         _index = null;
         _offersToNodes = null;
         var_416 = null;
         _catalog = null;
         _container = null;
         var_121 = null;
      }
      
      public function buildCatalogIndex(param1:class_2971) : void
      {
         _index = null;
         _offersToNodes = new Dictionary();
         _index = buildIndexNode(param1,0,null);
      }
      
      public function showIndex() : void
      {
         if(_index == null)
         {
            return;
         }
         var_121.removeListItems();
         if(var_1416 != null)
         {
            var_1416.clearTabs();
         }
         for each(var _loc1_ in _index.children)
         {
            if(_loc1_.visible)
            {
               if(_catalog.useNonTabbedCatalog())
               {
                  (_loc1_ as CatalogNodeRenderable).addToList(var_121);
               }
               else
               {
                  var_1416.addTabItem(_loc1_);
               }
            }
         }
         if(var_1416 != null)
         {
            var_1416.selectTabByIndex(0);
         }
      }
      
      public function showNodeContent(param1:class_1917) : void
      {
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:class_1917 = null;
         var _loc2_:* = false;
         if(_index == null)
         {
            return;
         }
         var_121.removeListItems();
         if(param1 == null || !param1.visible)
         {
            return;
         }
         if(param1.children.length)
         {
            for each(var _loc6_ in param1.children)
            {
               if(_loc6_.visible)
               {
                  (_loc6_ as CatalogNodeRenderable).addToList(var_121);
               }
            }
            _loc3_ = getPathToNodeWithLayout(param1);
            if(_loc3_.length > 0)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  _loc4_ = _loc3_[_loc5_];
                  _loc2_ = _loc5_ == _loc3_.length - 1;
                  if(_loc2_ || var_416.indexOf(_loc4_) == -1)
                  {
                     activateNode(_loc4_);
                  }
                  _loc5_++;
               }
            }
            else
            {
               openCatalogPage(param1);
            }
         }
         else
         {
            openCatalogPage(param1);
         }
      }
      
      private function getPathToNodeWithLayout(param1:class_1917) : Array
      {
         for each(var _loc3_ in param1.children)
         {
            if(_loc3_.visible)
            {
               if(_loc3_.pageId > -1)
               {
                  return [_loc3_];
               }
               if(_loc3_.isBranch)
               {
                  var _loc2_:Array = getPathToNodeWithLayout(_loc3_);
                  if(null.length > 0)
                  {
                     null.unshift(_loc3_);
                     return null;
                  }
               }
            }
         }
         return [];
      }
      
      private function openCategoryForNode(param1:class_1917) : class_1917
      {
         var _loc3_:int = 0;
         var _loc2_:class_1917 = param1.parent;
         while(_loc2_ != null && _loc2_.parent != null && _loc2_.parent.pageName != "root")
         {
            _loc2_ = _loc2_.parent;
         }
         if(var_1416 && _loc2_.parent)
         {
            _loc3_ = int(_loc2_.parent.children.indexOf(_loc2_));
            var_1416.selectTabByIndex(_loc3_);
         }
         showNodeContent(_loc2_);
         return _loc2_;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function activateNode(param1:class_1917) : void
      {
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc8_:* = var_416.indexOf(param1) >= 0;
         var _loc2_:Boolean = param1.isOpen;
         var _loc6_:Vector.<class_1917> = new Vector.<class_1917>(0);
         for each(var _loc4_ in var_416)
         {
            _loc4_.deactivate();
            if(_loc4_.depth < param1.depth)
            {
               _loc6_.push(_loc4_);
            }
            else
            {
               _loc4_.close();
            }
         }
         var_416 = _loc6_;
         param1.activate();
         if(_loc8_ && _loc2_)
         {
            param1.close();
         }
         else
         {
            param1.open();
         }
         if(var_416.indexOf(param1) < 0)
         {
            var_416.push(param1);
         }
         if(param1.isBranch)
         {
            if(param1.parent && param1.parent is CatalogNodeRenderable)
            {
               (param1.parent as CatalogNodeRenderable).updateChildListHeight();
            }
            _loc3_ = 0;
            _loc5_ = 0;
            var _loc7_:int = 0;
            while(0 < var_121.numListItems)
            {
               if(var_121.getListItemAt(0).visible)
               {
                  _loc5_ += var_121.getListItemAt(0).height;
               }
               _loc7_++;
            }
            for each(param1 in var_416)
            {
               _loc3_ += param1.offsetV;
            }
            if(_loc3_ - var_121.height > 0)
            {
               var_121.scrollV = _loc3_ / _loc5_;
            }
         }
         if(param1.pageId > -1)
         {
            openCatalogPage(param1);
         }
      }
      
      private function openCatalogPage(param1:class_1917) : void
      {
         _catalog.loadCatalogPage(param1.pageId,-1,var_327);
         _catalog.events.dispatchEvent(new CatalogPageOpenedEvent(param1.pageId,param1.localization));
      }
      
      public function openPage(param1:String) : void
      {
         var _loc2_:class_1917 = getNodeByName(param1);
         if(_loc2_ != null && _loc2_.visible)
         {
            _catalog.loadCatalogPage(_loc2_.pageId,-1,var_327);
            openNavigatorAtNode(_loc2_);
         }
         else
         {
            if(_loc2_ != null && !_loc2_.visible)
            {
               _catalog.events.dispatchEvent(new CatalogEvent("CATALOG_INVISIBLE_PAGE_VISITED"));
            }
            loadFrontPage();
         }
      }
      
      public function openPageById(param1:int, param2:int) : void
      {
         var _loc3_:class_1917 = null;
         if(!initialized)
         {
            _catalog.openCatalogPageById(param1,param2,var_327);
         }
         else
         {
            if(param1 == -12345678)
            {
               var _loc4_:Vector.<class_1917> = getNodesByOfferId(param2,true);
               if(_loc4_ != null)
               {
                  _loc3_ = undefined[0];
               }
            }
            else
            {
               _loc3_ = getNodeById(param1);
            }
            if(_loc3_ != null)
            {
               _catalog.loadCatalogPage(_loc3_.pageId,param2,var_327);
               openNavigatorAtNode(_loc3_);
            }
         }
      }
      
      public function openPageByOfferId(param1:int) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:class_1917 = null;
         if(!initialized)
         {
            _catalog.openCatalogPageById(-12345678,param1,var_327);
         }
         else
         {
            _loc3_ = getNodesByOfferId(param1);
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_[0];
               _catalog.loadCatalogPage(_loc2_.pageId,param1,var_327);
               openNavigatorAtNode(_loc2_);
            }
         }
      }
      
      public function deactivateCurrentNode() : void
      {
         for each(var _loc1_ in var_416)
         {
            _loc1_.deactivate();
            _loc1_.close();
         }
         var_416 = new Vector.<class_1917>(0);
      }
      
      public function filter(param1:String, param2:Array) : void
      {
         var _loc4_:Vector.<class_1917> = new Vector.<class_1917>(0);
         searchNodesWith(param1,param2,_index,_loc4_);
         var_121.removeListItems();
         for each(var _loc3_ in _loc4_)
         {
            class_21.log("Found node: " + [_loc3_.pageId,_loc3_.pageName,_loc3_.localization]);
            if(_loc3_.visible)
            {
               (_loc3_ as CatalogNodeRenderable).addToList(var_121);
            }
         }
      }
      
      private function openNavigatorAtNode(param1:class_1917) : void
      {
         if(param1 == null)
         {
            return;
         }
         deactivateCurrentNode();
         var _loc2_:class_1917 = param1.parent;
         while(_loc2_ != null && _loc2_.parent != null)
         {
            _loc2_.open();
            if(_catalog.useNonTabbedCatalog())
            {
               var_416.push(_loc2_);
            }
            _loc2_ = _loc2_.parent;
         }
         if(!_catalog.useNonTabbedCatalog())
         {
            openCategoryForNode(param1);
         }
         activateNode(param1);
      }
      
      public function loadFrontPage() : void
      {
         if(_index == null)
         {
            return;
         }
         var _loc1_:class_1917 = getFirstNavigable(_index);
         if(_loc1_ == null)
         {
            return;
         }
         class_21.log("Load front page: " + _loc1_.localization + "(" + _loc1_.pageId + ")");
         _catalog.loadCatalogPage(_loc1_.pageId,-1,var_327);
      }
      
      private function getFirstNavigable(param1:class_1917) : class_1917
      {
         var _loc2_:class_1917 = null;
         if(param1.visible && param1 != _index)
         {
            return param1;
         }
         for each(var _loc3_ in param1.children)
         {
            _loc2_ = getFirstNavigable(_loc3_);
            if(_loc2_ != null)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function buildIndexNode(param1:class_2971, param2:int, param3:class_1917) : class_1917
      {
         var _loc4_:class_1917 = null;
         var _loc5_:Boolean = param1.visible;
         if(!_loc5_)
         {
            _loc4_ = new CatalogNode(this,param1,param2,param3);
         }
         else
         {
            _loc4_ = new CatalogNodeRenderable(this,param1,param2,param3);
         }
         for each(var _loc6_ in _loc4_.offerIds)
         {
            if(_loc6_ in _offersToNodes)
            {
               _offersToNodes[_loc6_].push(_loc4_);
            }
            else
            {
               _offersToNodes[_loc6_] = new <class_1917>[_loc4_];
            }
         }
         param2++;
         for each(var _loc7_ in param1.children)
         {
            _loc4_.addChild(buildIndexNode(_loc7_,param2,_loc4_));
         }
         return _loc4_;
      }
      
      public function getNodesByOfferId(param1:int, param2:Boolean = false) : Vector.<class_1917>
      {
         var _loc4_:* = undefined;
         if(_offersToNodes != null)
         {
            if(param2)
            {
               _loc4_ = new Vector.<class_1917>(0);
               for each(var _loc3_ in _offersToNodes[param1])
               {
                  if(_loc3_.visible)
                  {
                     _loc4_.push(_loc3_);
                  }
               }
               if(_loc4_.length > 0)
               {
                  return _loc4_;
               }
               return null;
            }
            return _offersToNodes[param1];
         }
         return null;
      }
      
      public function getNodeByName(param1:String) : class_1917
      {
         return _index != null ? getFirstNodeByName(param1,_index) : null;
      }
      
      public function getOptionalNodeByName(param1:String) : class_1917
      {
         return _index ? getFirstNodeByName(param1,_index) : null;
      }
      
      public function getNodeById(param1:int, param2:class_1917 = null) : class_1917
      {
         if(param2 == null)
         {
            param2 = _index;
         }
         if(param2 == null)
         {
            return null;
         }
         var _loc3_:class_1917 = null;
         if(param2.pageId == param1 && param2 != _index)
         {
            _loc3_ = param2;
         }
         else
         {
            for each(var _loc4_ in param2.children)
            {
               _loc3_ = getNodeById(param1,_loc4_);
               if(_loc3_ != null)
               {
                  break;
               }
            }
         }
         return _loc3_;
      }
      
      private function getFirstNodeByName(param1:String, param2:class_1917) : class_1917
      {
         var _loc3_:class_1917 = null;
         try
         {
            if(param2.pageName == param1 && param2 != _index)
            {
               _loc3_ = param2;
            }
            else
            {
               for each(var _loc4_ in param2.children)
               {
                  _loc3_ = getFirstNodeByName(param1,_loc4_);
                  if(_loc3_ != null)
                  {
                     break;
                  }
               }
            }
         }
         catch(e:Error)
         {
            class_21.log("Error when loading node by name " + param1 + ":",e);
         }
         return _loc3_;
      }
      
      public function get listTemplate() : class_1741
      {
         return var_4067;
      }
      
      public function get isDeepHierarchy() : Boolean
      {
         return (_catalog as class_17).getBoolean("catalog.deep.hierarchy");
      }
      
      public function getItemTemplate(param1:int) : class_1741
      {
         if(isDeepHierarchy)
         {
            return param1 > 2 ? var_3625 : var_3426;
         }
         return param1 == 1 ? var_3426 : var_3625;
      }
   }
}

