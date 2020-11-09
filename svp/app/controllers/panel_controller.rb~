# Controlador de panel gestor.
# Aquí se controla cad sección y acción dentro del panel.
class PanelController < ApplicationController
  # Antes de renderizar cualquier página, se requiere autenticar al administrador.
  before_action :authenticate_admin!
  # También, se invoca al objeto que contiene la información de cada modelo de Base de Datos para seleccionar.
  before_action :select_set
  # Y también se recaban los campos de cada modelo en Base de Datos (salvo en página principal y panel).
  before_action :get_object_fields, except: [:panel, :principal]
  # Página "Panel"
  #No requiere nada de la Base de Datos.
  def panel
  end
  # Subsección principal.
  # No requiere nada de la Base de Datos.
  def principal
  end
  # Subsección "Índice" (para cada modelo de Base de Datos).
  # Requiere, como parámetros de la URL:
  # - sort_c: Un arreglo con los nombres de los campos del modelo que se van a ordenar.
  # - sort_d: Un arreglo con los sentidos de ordenamiento de los campos del modelo.
  # - filt_fo: Un arreglo que indica los campos y el tipo de operación para filtrar sobre los campos del modelo.
  # - filt_v: Un arreglo que indica los valores con los cuales se operará para filtrar sobre los campos del modelo.
  # - keyword: Una cadena que representa la(s) palabr(s) clave para realizar un filtrado más general.
  # - offset: Un valor numérico que representa el número de página desde el cuál se realizará la búsqueda de los registros.
  # Requiere de la Base de Datos:
  # - @count: La cuenta de todos los resultados obtenidos tras el filtrado.
  # - @set: El total de registros obtenidos tras el filtrado y ordenamiento y de acuerdo a la cantidad de elementos por página.
  # - @pags: La cantidad de páginas que se obtiene tras el filtrado de todos los resultados.
  # Se ejecuta un script de Javascript que renderiza la subsección.
  def index
    @filter_query = ""
    # Hash que almacena los campos y sentidos de ordenamiento.
    @sort_hash = (params[:sort_c] && params[:sort_d] ? Hash[params[:sort_c].map {|x| CGI.unescape(x) }.zip(params[:sort_d].map {|x| CGI.unescape(x).to_sym })] : "")
    if params[:filt_fo] && params[:filt_v]
      # Tipos de operadores disponibles para filtrar.
      operadores = {"like": " like ", "leq": " <= ", "geq": " >= ", "eq": " = "}
      # Arreglo de nombres de campos a filtrar.
      campos = params[:filt_fo].map {|x| CGI.unescape(x.split("*")[0]) }
      # Arreglo de operadores a aplicar en el filtrado.
      ops = params[:filt_fo].map {|x| operadores[CGI.unescape(x.split("*")[1]).to_sym] }
      # Arreglo de valores para comparar en el filtrado.
      vals = params[:filt_v].map {|x| CGI.unescape(x).gsub("'","''") }
      # Arreglo de conjunto de camps, operadores y valores para filtrado.
      @filter_query = campos.zip(ops,vals).map {|a| (@models.columns_hash[a[0]].type == :text ? ("lower(" + a[0] + ")") : a[0]) + a[1] + (a[1] == " like " ? ("lower('%" + a[2].gsub("\\","\\\\").gsub('%',"\\%").gsub("_","\\_") + "%')") : (a[1] == " = " ? ("lower('" + a[2].gsub("\\","\\\\") + "')") : (@models.columns_hash[a[0]].type == :date ? ("str_to_date('" + a[2] + "','%Y-%m-%d')") : a[2]))) }.join(" AND ")
    end
    # Si keyword está presente en la URL, lo concatena a la condición de filtrado.
    if params[:keyword] && params[:keyword] != ""
      @filter_query = @filter_query + (@filter_query.size > 0 ? " AND " : "") + query(params[:keyword])
    end
    @rpp = 10
    @count = @models.where(@filter_query).count
    @set = @models.where(@filter_query).order(@sort_hash.empty? ? "updated_at DESC" : @sort_hash).limit(@rpp).offset(params[:offset].to_i*@rpp)
    @pags = (@count == 0 ? 0 : ((@count / @rpp) + (@count % @rpp == 0 ? 0 : 1) ))
    respond_to do |format|
      format.js
    end
  end
  # Subsección "mostrar" (cualquier modelo de Base de Datos).
  # Toma, como parámetros de la URL:
  # - set: El nombre de la sección sobre la que se va a mostrar el registro.
  # - id: El id de Base de Datos para el registro del modelo.
  # Se ejecuta un script de Javascript para renderizar la subsección.
  def mostrar
    @obj = @sets[params[:set].to_sym][:model].find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end
  # Subsección "generar" (cualquier modelo de Base de Datos).
  #  Toma, como parámetros de la URL:
  # - set: El nombre de la sección sobre la cual se va a generar el registro.
  # Se ejecuta un script de Javascript para renderizar la subsección.
  # NOTA: Se ejecuta previo a "crear" ya que sólo instancia la generación de un nuevo objeto genérico y vacío.
  # Los campos se llenan al mandar el formulario y procesarse el mismo.
  def generar
    @obj = @sets[params[:set].to_sym][:model].new
    respond_to do |format|
      format.js
    end
  end
  # POST Crear.
  # Esta rutina se ejecuta al enviar el formulario de generación de objeto en la subsección "generar".
  # Recibe, como parámetros de la URL:
  # - set: El nombre del modelo del cual se va a generar un nuevo registro.
  # Ejecuta un script de Javascript: En caso de éxito al guardar el registro, se redirige a la subsección "mostrar".
  # En caso de error en el formulario, redirige a la subsección "generar" para corregir los errores del formulario.
  def crear
    @obj = @sets[params[:set].to_sym][:model].new(obj_params)
    respond_to do |format|
      if @obj.save
        format.js { render :mostrar, params: {set: params[:set], id: @obj.id}, notice: 'Objeto generado exitosamente.' }
      else
        format.js { render :generar }
        format.json { render json: @obj.errors, status: :unprocessable_entity }
      end
    end
  end
  # Subsección "editar" (para todo modelo de Base de Datos).
  # Recibe, como parámetros de la URL:
  # - set: El nombre de la sección de la cual se quiere editar el registro del modelo.
  # - id: El identificador del registro del modelo a editar.
  # Se ejecuta un script de Javascript para renderizar la subsección.
  def editar
    @obj = @sets[params[:set].to_sym][:model].find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  # POST Actualizar.
  # Esta rutina se ejecuta al enviar el formulario de edición de objeto en la subsección "editar".
  # Recibe, como parámetros de la URL:
  # - set: El nombre de la sección de la cual se quiere editar el registro del modelo.
  # - id: El identificador del registro del modelo a editar.
  # Ejecuta un script de Javascript: En caso de éxito al guardar el registro, se redirige a la subsección "mostrar".
  # En caso de error en el formulario, redirige a la subsección "editar" para corregir los errores del formulario.
  def actualizar
    @obj = @sets[params[:set].to_sym][:model].find(params[:id])
    respond_to do |format|
      if @obj.update(obj_params)
        format.js { render :mostrar, params: {set: params[:set], id: @obj.id}, notice: 'Objeto generado exitosamente.' }
      else
        format.js { render :editar }
        format.json { render json: @obj.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE Eliminar.
  # Se ejecuta al dar click al ícono de acción "Eliminar" en la fila del registro.
  # Recibe, como parámetros de la URL:
  # - set: El nombre de la sección de la cual se quiere eliminar el registro.
  # - id: El identificador del objeto que se va a eliminar.
  # Requiere de la Base de Datos:
  # - @count: El número de registros nuevo tras eliminar.
  # - @pags: El número de páginas tras la eliminación del registro.
  # Se ejecuta un script de Javascript que redirige a la tabla de índice.
  def eliminar
    @sets[params[:set].to_sym][:model].find(params[:id]).destroy
    @set = @sets[params[:set].to_sym][:model].order(updated_at: :desc).limit(@rpp).offset(0)
    @rpp = 10
    @count = @sets[params[:set].to_sym][:model].count
    @pags = (@count == 0 ? 0 : ((@count / @rpp) + (@count % @rpp == 0 ? 0 : 1) ))
    respond_to do |format|
      format.js { render :index, params: {set: params[:set]}, notice: 'Se ha eliminado el objeto exitosamente'}
      format.json { head :no_content }
    end
  end

  private
  # Función que se encarga de ensamblar el query de búsqueda con la palabra clave para filtrar en la Base de Datos.
  # Recibe como parámetros:
  # - keyword: La palabra clave registrada en el respectivo campo de filtrado.
  # Regresa una cadena que representa el query a la Base de Datos para buscar con respecto de la palabra clave.
  def query(keyword)
    or_query = "("
    (@models.columns_hash.keys - ["id", "created_at", "updated_at"]).each do |k|
      or_query = or_query + (or_query != "(" ? " OR " : "") + "unaccent(lower(text(" + k + "))) ilike '%" + keyword.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.gsub('%',"¸%").gsub("_","¸_") + "%' escape '¸'"
    end
    return or_query + ")"
  end
  # Variable que almacena los modelos de Base de Datos con sus respectivos campos desglosados para ensamblar el formulario de generación/edición.
  # No recibe parámetros.
  # No requiere nada de la Base de Datos.
  def select_set
    @sets = {
      # Modelo para Colaboradores
      "Colaboradores": {
        model: Persona, 
        fields: {nombre: "Nombre", semblanza: "Semblanza", twitter: "Liga a cuenta Twitter", fb: "Liga a cuenta de Facebook", indice: "Índice"},
        imgs: {foto: "Fotografía"},
        p_text: [:nombre, :twitter, :fb],
        numbers: [:indice],
        trix: [:semblanza]
      # Modelo para estudiantes del histórico.
      }, "Publicaciones": {
        model: Publicacion,
        fields: {titulo: "Título", fecha: "Fecha de publicación", autor: "Autor(es)", edicion: "Edición", descripcion: "Descripción", liga_vid: "Liga(s) a video", indice: "Índice"},
        imgs: {portada: "Portada"},
        textarea: [:autor, :edicion, :liga_vid],
        numbers: [:indice],
        trix: [:descripcion],
        dates: [:fecha],
        p_text: [:titulo]
      }, "Sesiones": {
        model: Sesion,
        fields: {titulo: "Título del evento", descripcion: "Descripción", liga_vid: "Liga(s) a video", pubs: "Publicaciones", fecha_i: "Fecha de inicio", fecha_f: "Fecha de término"},
        imgs: {banner: "Banner del evento (opcional)"},
        p_text: [:titulo],
        dates: [:fecha_i, :fecha_f],
        trix: [:descripcion],
        textarea: [:liga_vid],
        check: {pubs: Publicacion.all.map{|x| [x.titulo, x.titulo]}}
      }, "Sliders": {
        model: Slider,
        fields: {liga: "Liga"},
        imgs: {banner: "Imagen de fondo"},
      #  dates: [:fecha_i, :fecha_f],
        p_text: [:liga]
      #  select: {posicion: [["Superior izquierda","top-left"],["Superior centrado","top-center"],["Superior derecha","top-right"],["Centrado izquierda","center-left"],["Centrado","center"],["Centrado derecha","center-right"],["Inferior izquierda","bottom-left"],["Inferior centrado","bottom-center"],["Inferior derecha","bottom-right"]]}
      }, "Videos": {
        model: Vid,
        fields: {liga: "Liga del video", indice: "Índice"},
        p_text: [:liga],
        numbers: [:indice]
      }, "Imágenes de sesiones": {
        model: Imagen,
        fields: {caption: "Descripción", sesion: "Sesión", indice: "Índice"},
        imgs: {imagen: "Imagen"},
        numbers: [:indice],
        select: {sesion: Sesion.order(fecha_i: :desc).map{|x| [x.titulo, x.titulo]}},
        p_text: [:caption]
      }
    }
  end
  # Función que regresa, como variables globales, los campos de los modelos seleccionados.
  # No requiere parámetros.
  # Regresa las variables globales de campos para poblar el formulario.
  def get_object_fields
    # Todos los campos que no son de archivo.
    @fields = @sets[params[:set].to_sym][:fields] || {}
    # Todos los campos que son archivos.
    @imgs = @sets[params[:set].to_sym][:imgs] || {}
    # El modelo en Base de Datos de la sección.
    @models = @sets[params[:set].to_sym][:model]
    # Todos los campos de fechas.
    @dates = @sets[params[:set].to_sym][:dates] || []
    # Todos los campos de editor de texto.
    @trix = @sets[params[:set].to_sym][:trix] || []
    # Todos los campos numéricos.
    @numbers = @sets[params[:set].to_sym][:numbers] || []
    # Todos los campos de texto plano.
    @plains = @sets[params[:set].to_sym][:p_text] || []
    # Todos los campos con áreas de texto.
    @textareas = @sets[params[:set].to_sym][:textarea] || []
    # Todos los campos que incluyen selección.
    @selects = @sets[params[:set].to_sym][:select] || {}
    # Todos los campos que requieren check boxes.
    @checks = @sets[params[:set].to_sym][:check] || {}
    # Todos los campos que son obligatorios.
    @presence = @models.validators.collect{|v| v if v.class == ActiveRecord::Validations::PresenceValidator }.compact.collect(&:attributes).flatten || []
  end
  # Función que indica los parámetros válidos para cada modelo de la Base de Datos.
  # Toma como parámetros las variables obtenidas en la función "get_fields".
  def obj_params
    campos = @fields.keys + @imgs.keys + @imgs.keys.map{|k| (k.to_s + "_del").to_sym}
    params.require(@models.to_s.underscore.to_sym).permit(campos, @checks.keys.map{|k| [k,[]]}.to_h, @imgs.keys.map{|k| [k,[]]}.to_h )
  end
end
