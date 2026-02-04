package com.sulake.habbo.window
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IResourceManager;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.runtime.class_39;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.class_1860;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.utils.profiler.ProfilerAgentTask;
   import com.sulake.core.window.IInputEventTracker;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.class_1892;
   import com.sulake.core.window.class_1901;
   import com.sulake.core.window.class_35;
   import com.sulake.core.window.class_36;
   import com.sulake.core.window.class_37;
   import com.sulake.core.window.components.HTMLTextController;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.*;
   import com.sulake.core.window.graphics.SkinContainer;
   import com.sulake.core.window.graphics.WindowRenderer;
   import com.sulake.core.window.graphics.class_1770;
   import com.sulake.core.window.graphics.renderer.ISkinRenderer;
   import com.sulake.core.window.theme.IThemeManager;
   import com.sulake.core.window.tools.*;
   import com.sulake.core.window.utils.DefaultAttStruct;
   import com.sulake.core.window.utils.INotify;
   import com.sulake.core.window.utils.MouseCursorControl;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.core.window.utils.class_1896;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.freeflowchat.class_51;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.window.handlers.HabbletLinkHandler;
   import com.sulake.habbo.window.theme.ThemeManager;
   import com.sulake.habbo.window.utils.AlertDialog;
   import com.sulake.habbo.window.utils.AlertDialogWithLink;
   import com.sulake.habbo.window.utils.ConfirmDialog;
   import com.sulake.habbo.window.utils.ElementPointerHandler;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.window.utils.ModalDialog;
   import com.sulake.habbo.window.utils.SimpleAlertDialog;
   import com.sulake.habbo.window.utils.class_2213;
   import com.sulake.habbo.window.utils.floorplaneditor.BCFloorPlanEditor;
   import com.sulake.habbo.window.utils.habbopedia.HabboPagesViewer;
   import com.sulake.habbo.window.widgets.class_2086;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.text.StyleSheet;
   import flash.utils.getTimer;
   
   public class HabboWindowManagerComponent extends class_17 implements class_38, class_37, class_36, class_31, IInputEventTracker, class_35
   {
      
      private static const NUMBER_OF_CONTEXT_LAYERS:uint = 4;
      
      private static const DEFAULT_CONTEXT_LAYER_INDEX:uint = 1;
      
      private static const TRACKING_EVENT_INPUT:Event = new Event("HABBO_WINDOW_TRACKING_EVENT_INPUT");
      
      private static const TRACKING_EVENT_RENDER:Event = new Event("HABBO_WINDOW_TRACKING_EVENT_RENDER");
      
      private static const TRACKING_EVENT_SLEEP:Event = new Event("HABBO_WINDOW_TRACKING_EVENT_SLEEP");
      
      private var _localization:class_27;
      
      private var _windowContextArray:Array;
      
      private var var_1050:class_1892;
      
      private var _windowRenderer:class_1770;
      
      private var var_779:SkinContainer;
      
      private var var_2664:Boolean = false;
      
      private var var_3709:ProfilerOutput;
      
      private var _profilerAgentTaskUpdate:ProfilerAgentTask;
      
      private var _profilerAgentTaskRedraw:ProfilerAgentTask;
      
      private var var_5159:ThemeManager;
      
      private var var_1716:ResourceManager;
      
      private var _hintManager:HintManager;
      
      private var _avatarRenderer:class_48;
      
      private var _communication:class_57;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _freeFlowChat:class_51;
      
      private var _catalog:IHabboCatalog;
      
      private var var_265:Boolean = false;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_5372:uint;
      
      private var _bcfloorPlanEditor:BCFloorPlanEditor;
      
      private var var_1576:HabboPagesViewer;
      
      private var var_1528:HabbletLinkHandler;
      
      private var var_2651:ElementPointerHandler;
      
      public function HabboWindowManagerComponent(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         class_1860.refresh();
         HTMLTextController.defaultLinkTarget = "habboMain";
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },false),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:class_51):void
         {
            _freeFlowChat = param1;
         },false),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },false),new ComponentDependency(new IIDHabboConfigurationManager(),function(param1:class_16):void
         {
         },false,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }]),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderer = param1;
         },false),new ComponentDependency(new IIDHabboCommunicationManager(),setCommunicationManager,false),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false)]);
      }
      
      private function setCommunicationManager(param1:class_57) : void
      {
         _communication = param1;
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         if(_communication != null)
         {
            _bcfloorPlanEditor = new BCFloorPlanEditor(this);
            var_2651 = new ElementPointerHandler(this);
         }
      }
      
      override protected function initComponent() : void
      {
         var _loc1_:int = getTimer();
         var _loc2_:IAsset = assets.getAssetByName("habbo_element_description_xml");
         var_779 = new SkinContainer();
         class_2213.parse(_loc2_.content as XML,assets,var_779);
         var_5159 = new ThemeManager(var_779);
         var_1716 = new ResourceManager(this);
         _hintManager = new HintManager(this);
         _windowRenderer = new WindowRenderer(var_779);
         _windowContextArray = new Array(4);
         var _loc4_:Rectangle = new Rectangle(0,0,context.displayObjectContainer.stage.stageWidth,context.displayObjectContainer.stage.stageHeight);
         var _loc3_:uint = 0;
         while(true)
         {
            _windowContextArray[0] = new WindowContext("layer_" + 0,_windowRenderer,this,this,var_1716,_localization,this,context.displayObjectContainer,_loc4_,context.linkEventTrackers);
            _loc3_ = 0 + 1;
         }
      }
      
      public function toggleFullScreen() : void
      {
         if(context.displayObjectContainer.stage.displayState == "fullScreenInteractive")
         {
            context.displayObjectContainer.stage.displayState = "normal";
         }
         else
         {
            context.displayObjectContainer.stage.displayState = "fullScreenInteractive";
         }
      }
      
      private function receiveProfilerInterface(param1:IID, param2:IUnknown) : void
      {
         var _loc3_:class_39 = param2 as class_39;
         if(_loc3_ != null)
         {
            if(!var_3709)
            {
               var_3709 = new ProfilerOutput(context,this,_windowRenderer);
            }
            var_3709.profiler = _loc3_;
            _profilerAgentTaskUpdate = new ProfilerAgentTask("Update","Event processing");
            _loc3_.getProfilerAgentForReceiver(this).addSubTask(_profilerAgentTaskUpdate);
            _profilerAgentTaskRedraw = new ProfilerAgentTask("Redraw","Window rasterizer");
            _loc3_.getProfilerAgentForReceiver(this).addSubTask(_profilerAgentTaskRedraw);
            var_2664 = true;
         }
      }
      
      private function receiveLoggerInterface(param1:IID, param2:IUnknown) : void
      {
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_1528 != null)
            {
               context.removeLinkEventTracker(var_1528);
               var_1528.dispose();
               var_1528 = null;
            }
            if(var_2651 != null)
            {
               var_2651.dispose();
               var_2651 = null;
            }
            removeUpdateReceiver(this);
            if(_bcfloorPlanEditor != null)
            {
               _bcfloorPlanEditor.dispose();
               _bcfloorPlanEditor = null;
            }
            if(var_1576)
            {
               var_1576.dispose();
               var_1576 = null;
            }
            if(_windowContextArray)
            {
               while(_windowContextArray.length > 0)
               {
                  class_13(_windowContextArray.pop()).dispose();
               }
            }
            _windowContextArray = null;
            if(_windowRenderer)
            {
               _windowRenderer.dispose();
               _windowRenderer = null;
            }
            if(var_779)
            {
               var_779.dispose();
               var_779 = null;
            }
            if(var_1716 != null)
            {
               var_1716.dispose();
               var_1716 = null;
            }
            if(_hintManager != null)
            {
               _hintManager.dispose();
               _hintManager = null;
            }
            super.dispose();
         }
      }
      
      public function create(param1:String, param2:uint, param3:uint, param4:uint, param5:Rectangle, param6:Function = null, param7:String = "", param8:uint = 0, param9:Array = null, param10:class_1741 = null, param11:Array = null, param12:String = "") : class_1741
      {
         return var_1050.create(param1,param7,param2,param3,param4,param5,param6,param10,param8,param11,param12,param9);
      }
      
      public function destroy(param1:class_1741) : void
      {
         param1.destroy();
      }
      
      public function buildFromXML(param1:XML, param2:uint = 1, param3:class_55 = null) : class_1741
      {
         var _loc4_:class_1741 = getWindowContext(param2).getWindowParser().parseAndConstruct(param1,null,param3);
         if(_loc4_ is class_2250)
         {
            class_2250(_loc4_).helpButtonAction = openHelpPage;
         }
         return _loc4_;
      }
      
      public function windowToXMLString(param1:class_1741) : String
      {
         return var_1050.getWindowParser().windowToXMLString(param1);
      }
      
      public function getLayoutByTypeAndStyle(param1:uint, param2:uint) : XML
      {
         return var_779.getWindowLayoutByTypeAndStyle(param1,param2);
      }
      
      public function getDefaultsByTypeAndStyle(param1:uint, param2:uint) : DefaultAttStruct
      {
         return var_779.getDefaultAttributesByTypeAndStyle(param1,param2);
      }
      
      public function getRendererByTypeAndStyle(param1:uint, param2:uint) : ISkinRenderer
      {
         return var_779.getSkinRendererByTypeAndStyle(param1,param2);
      }
      
      public function createWindow(param1:String, param2:String = "", param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:Rectangle = null, param7:Function = null, param8:uint = 0, param9:uint = 1, param10:String = "") : class_1741
      {
         return _windowContextArray[param9].create(param1,param2,param3,param4,param5,param6,param7,null,param8,null,null,null);
      }
      
      public function removeWindow(param1:String, param2:uint = 1) : void
      {
         var _loc3_:class_2052 = null;
         _loc3_ = _windowContextArray[param2].getDesktopWindow();
         var _loc4_:class_1741 = _loc3_.getChildByName(param1);
         if(_loc4_ != null)
         {
            _loc4_.destroy();
         }
      }
      
      public function getWindowByName(param1:String, param2:uint = 1) : class_1741
      {
         return _windowContextArray[param2].getDesktopWindow().getChildByName(param1);
      }
      
      public function getActiveWindow(param1:uint = 1) : class_1741
      {
         return _windowContextArray[param1].getDesktopWindow().getChildAt(var_1050.getDesktopWindow().numChildren - 1);
      }
      
      public function getWindowContext(param1:uint) : class_1892
      {
         return _windowContextArray[param1];
      }
      
      public function getDesktop(param1:uint) : class_2052
      {
         var _loc2_:class_1892 = _windowContextArray[param1];
         return _loc2_ ? _loc2_.getDesktopWindow() : null;
      }
      
      public function notify(param1:String, param2:String, param3:Function, param4:uint = 0) : INotify
      {
         var _loc6_:IAsset = assets.getAssetByName("habbo_window_alert_xml");
         if(!_loc6_)
         {
            throw new Error("Failed to initialize alert dialog; missing asset!");
         }
         var _loc5_:XML = _loc6_.content as XML;
         return new AlertDialog(this,_loc5_,param1,param2,param4,param3,false);
      }
      
      public function alert(param1:String, param2:String, param3:uint, param4:Function) : class_1750
      {
         var _loc6_:IAsset = assets.getAssetByName("habbo_window_alert_xml");
         if(!_loc6_)
         {
            throw new Error("Failed to initialize alert dialog; missing asset!");
         }
         var _loc5_:XML = _loc6_.content as XML;
         return new AlertDialog(this,_loc5_,param1,param2,param3,param4,false);
      }
      
      public function alertWithModal(param1:String, param2:String, param3:uint, param4:Function) : class_1750
      {
         var _loc6_:IAsset = assets.getAssetByName("habbo_window_alert_xml");
         if(!_loc6_)
         {
            throw new Error("Failed to initialize alert dialog; missing asset!");
         }
         var _loc5_:XML = _loc6_.content as XML;
         return new AlertDialog(this,_loc5_,param1,param2,param3,param4,true);
      }
      
      public function alertWithLink(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:Function) : class_1896
      {
         var _loc8_:IAsset = assets.getAssetByName("habbo_window_alert_link_xml");
         if(!_loc8_)
         {
            throw new Error("Failed to initialize alert dialog; missing asset!");
         }
         var _loc7_:XML = _loc8_.content as XML;
         return new AlertDialogWithLink(this,_loc7_,param1,param2,param3,param4,param5,param6);
      }
      
      public function confirm(param1:String, param2:String, param3:uint, param4:Function) : class_2001
      {
         var _loc6_:IAsset = assets.getAssetByName("habbo_window_confirm_xml");
         if(!_loc6_)
         {
            throw new Error("Failed to initialize aleret dialog; missing asset!");
         }
         var _loc5_:XML = _loc6_.content as XML;
         return new ConfirmDialog(this,_loc5_,param1,param2,param3,param4,false);
      }
      
      public function confirmWithModal(param1:String, param2:String, param3:uint, param4:Function) : class_2001
      {
         var _loc6_:IAsset = assets.getAssetByName("habbo_window_confirm_xml");
         if(!_loc6_)
         {
            throw new Error("Failed to initialize alert dialog; missing asset!");
         }
         var _loc5_:XML = _loc6_.content as XML;
         return new ConfirmDialog(this,_loc5_,param1,param2,param3,param4,true);
      }
      
      public function registerLocalizationParameter(param1:String, param2:String, param3:String, param4:String = "%") : void
      {
         _localization.registerParameter(param1,param2,param3,param4);
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:int = 0;
         if(var_2664)
         {
            _profilerAgentTaskUpdate.start();
         }
         if(WindowContext.inputEventQueue.length > 0)
         {
            events.dispatchEvent(TRACKING_EVENT_INPUT);
            _loc2_ = 4 - 1;
            while(_loc2_ >= 0)
            {
               _windowContextArray[_loc2_].update(param1);
               _loc2_--;
            }
         }
         if(var_2664)
         {
            _profilerAgentTaskUpdate.stop();
         }
         if(var_2664)
         {
            _profilerAgentTaskRedraw.start();
         }
         events.dispatchEvent(TRACKING_EVENT_RENDER);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _windowContextArray[_loc2_].render(param1);
            _loc2_++;
         }
         if(var_2664)
         {
            _profilerAgentTaskRedraw.stop();
         }
         if(WindowContext.inputEventQueue.length > 0)
         {
            WindowContext.inputEventQueue.flush();
         }
         MouseCursorControl.change();
         events.dispatchEvent(TRACKING_EVENT_SLEEP);
      }
      
      override public function purge() : void
      {
         super.purge();
         if(_windowRenderer)
         {
            _windowRenderer.purge();
         }
      }
      
      public function addMouseEventTracker(param1:IInputEventTracker) : void
      {
         for each(var _loc2_ in _windowContextArray)
         {
            _loc2_.addMouseEventTracker(param1);
         }
      }
      
      public function removeMouseEventTracker(param1:IInputEventTracker) : void
      {
         for each(var _loc2_ in _windowContextArray)
         {
            _loc2_.removeMouseEventTracker(param1);
         }
      }
      
      public function eventReceived(param1:class_1758, param2:class_1741) : void
      {
         if(param2 != null)
         {
            if(param1.type == "WME_CLICK")
            {
               ErrorReportStorage.setParameter("click_time",new Date().getTime().toString());
               ErrorReportStorage.setParameter("click_target",param2.name + ": " + param2.toString());
            }
            else if(param1.type == "WME_UP")
            {
               ErrorReportStorage.setParameter("mouse_up_time",new Date().getTime().toString());
               ErrorReportStorage.setParameter("mouse_up_target",param2.name + ": " + param2.toString());
            }
         }
      }
      
      private function performTestCases() : void
      {
         class_21.log("type: " + Capabilities.playerType + " debugger: " + Capabilities.isDebugger + " version: " + Capabilities.version);
      }
      
      public function findWindowByName(param1:String) : class_1741
      {
         var _loc2_:class_1741 = null;
         for each(var _loc3_ in _windowContextArray)
         {
            _loc2_ = _loc3_.findWindowByName(param1);
            if(_loc2_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function findWindowByTag(param1:String) : class_1741
      {
         var _loc2_:class_1741 = null;
         for each(var _loc3_ in _windowContextArray)
         {
            _loc2_ = _loc3_.findWindowByTag(param1);
            if(_loc2_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function groupWindowsWithTag(param1:String, param2:Array, param3:int = 0) : uint
      {
         var _loc4_:uint = 0;
         for each(var _loc5_ in _windowContextArray)
         {
            _loc4_ += _loc5_.groupChildrenWithTag(param1,param2,param3);
         }
         return _loc4_;
      }
      
      public function getThemeManager() : IThemeManager
      {
         return var_5159;
      }
      
      public function createUnseenItemCounter() : class_1812
      {
         var _loc1_:IAsset = assets.getAssetByName("unseen_item_counter_xml") as IAsset;
         var _loc2_:XML = _loc1_.content as XML;
         return buildFromXML(_loc2_) as class_1812;
      }
      
      public function createWidget(param1:String, param2:class_2010) : class_1901
      {
         var _loc3_:Class = class_2086.var_141[param1];
         if(_loc3_ != null)
         {
            return new _loc3_(param2,this);
         }
         throw new Error("Unknown widget type " + param1 + "! You might need to update Glaze to be able to work on this layout.");
      }
      
      public function get avatarRenderer() : class_48
      {
         return _avatarRenderer;
      }
      
      public function get resourceManager() : IResourceManager
      {
         return var_1716;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function buildModalDialogFromXML(param1:XML) : IModalDialog
      {
         return new ModalDialog(this,param1);
      }
      
      public function get communication() : class_57
      {
         return _communication;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function simpleAlert(param1:String, param2:String, param3:String, param4:String = null, param5:String = null, param6:class_55 = null, param7:String = null, param8:Function = null, param9:Function = null) : void
      {
         new SimpleAlertDialog(this,param1,param2,param3,param4,param5,param6,param7,param8,param9);
      }
      
      public function registerHintWindow(param1:String, param2:class_1741, param3:int = 1) : void
      {
         _hintManager.registerWindow(param1,param2,param3);
      }
      
      public function unregisterHintWindow(param1:String) : void
      {
         _hintManager.unregisterWindow(param1);
      }
      
      public function showHint(param1:String, param2:Rectangle = null) : void
      {
         _hintManager.showHint(param1,param2);
      }
      
      public function hideHint() : void
      {
         _hintManager.hideHint();
      }
      
      public function hideMatchingHint(param1:String) : void
      {
         _hintManager.hideMatchingHint(param1);
      }
      
      public function displayFloorPlanEditor() : void
      {
         if(_bcfloorPlanEditor == null)
         {
            _bcfloorPlanEditor = new BCFloorPlanEditor(this);
         }
         if(_bcfloorPlanEditor != null)
         {
            _bcfloorPlanEditor.visible = true;
         }
      }
      
      public function openHelpPage(param1:String) : void
      {
         if(var_1576 != null)
         {
            var_1576.openPage(param1);
         }
      }
      
      public function get habboPagesStyleSheet() : StyleSheet
      {
         return HabboPagesViewer.styleSheet;
      }
      
      public function get freeFlowChat() : class_51
      {
         return _freeFlowChat;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
   }
}

