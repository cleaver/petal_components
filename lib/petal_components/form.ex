defmodule PetalComponents.Form do
  use Phoenix.Component

  import PetalComponents.Helpers
  import Phoenix.HTML.Form

  @moduledoc """
  Everything related to forms: inputs, labels etc
  """

  # prop form, :any
  # prop field, :any
  # prop label, :string
  # prop class, :string
  # slot default
  def form_label(assigns) do
    assigns =
      assigns
      |> assign_new(:classes, fn -> label_classes(assigns) end)
      |> assign_new(:form, fn -> nil end)
      |> assign_new(:has_error, fn -> false end)
      |> assign_new(:field, fn -> nil end)
      |> assign_new(:inner_block, fn -> nil end)
      |> assign_new(:label, fn ->
        if assigns[:field] do
          humanize(assigns[:field])
        else
          nil
        end
      end)
      |> assign_rest(~w(classes form field label)a)

    ~H"""
    <%= if @form && @field do %>
      <%= label @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest do %>
        <%= if @inner_block do %>
          <%= render_slot(@inner_block) %>
        <% else %>
          <%= @label %>
        <% end %>
      <% end %>
    <% else %>
      <label class={@classes} {@rest}>
        <%= if @inner_block do %>
          <%= render_slot(@inner_block) %>
        <% else %>
          <%= @label %>
        <% end %>
      </label>
    <% end %>
    """
  end

  # prop form, :any, required: true
  # prop field, :any, required: true
  # prop type, :string, required: true, options: ["text_input", "email_input", "number_input", "password_input", "search_input", "telephone_input", "url_input", "time_input", "time_select", "datetime_local_input", "datetime_select", "color_input", "file_input", "range_input", "textarea", "select", "checkbox", "radio_gro"]
  # prop disabled, :boolean, default: false, options: ["text_input"]
  # prop label, :string
  # prop wrapper_classes, :string

  @doc "Use this when you want to include the label and some margin."
  def form_field(assigns) do
    assigns =
      assigns
      |> assign_new(:input_opts, fn ->
        assigns_to_attributes(assigns, [
          :form,
          :field,
          :label,
          :field_type,
          :wrapper_classes
        ])
      end)
      |> assign_new(:label, fn ->
        if assigns[:field] do
          humanize(assigns[:field])
        else
          nil
        end
      end)
      |> assign_new(:wrapper_classes, fn -> "mb-6" end)

    ~H"""
    <div class={@wrapper_classes}>
      <%= case @type do %>
        <% "checkbox" -> %>
          <label class="inline-flex items-center gap-3">
            <.checkbox form={@form} field={@field} {@input_opts} />
            <div class={label_classes(%{form: @form, field: @field, type: "checkbox"})}><%= @label %></div>
          </label>
        <% "switch" -> %>
          <label class="inline-flex items-center gap-3">
            <.switch form={@form} field={@field} {@input_opts} />
            <div class={label_classes(%{form: @form, field: @field, type: "checkbox"})}><%= @label %></div>
          </label>
        <% "checkbox_group" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.checkbox_group form={@form} field={@field} {@input_opts} />
        <% "radio_group" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.radio_group form={@form} field={@field} {@input_opts} />
        <% "text_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.text_input form={@form} field={@field} {@input_opts} />
        <% "email_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.email_input form={@form} field={@field} {@input_opts} />
        <% "number_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.number_input form={@form} field={@field} {@input_opts} />
        <% "password_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.password_input form={@form} field={@field} {@input_opts} />
        <% "search_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.search_input form={@form} field={@field} {@input_opts} />
        <% "telephone_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.telephone_input form={@form} field={@field} {@input_opts} />
        <% "url_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.url_input form={@form} field={@field} {@input_opts} />
        <% "time_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.time_input form={@form} field={@field} {@input_opts} />
        <% "time_select" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.time_select form={@form} field={@field} {@input_opts} />
        <% "datetime_select" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.datetime_select form={@form} field={@field} {@input_opts} />
        <% "datetime_local_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.datetime_local_input form={@form} field={@field} {@input_opts} />
        <% "date_select" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.date_select form={@form} field={@field} {@input_opts} />
        <% "date_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.date_input form={@form} field={@field} {@input_opts} />
        <% "color_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.color_input form={@form} field={@field} {@input_opts} />
        <% "file_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.file_input form={@form} field={@field} {@input_opts} />
        <% "range_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.range_input form={@form} field={@field} {@input_opts} />
        <% "textarea" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.textarea form={@form} field={@field} {@input_opts} />
        <% "select" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.select form={@form} field={@field} {@input_opts} />
      <% end %>

      <.form_field_error class="mt-1" form={@form} field={@field} />
    </div>
    """
  end

  def text_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= text_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def email_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= email_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def number_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= number_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def password_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= password_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def search_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= search_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def telephone_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= telephone_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def url_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= url_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def time_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= time_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def time_select(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <div class="select-wrapper dark:text-white">
      <%= time_select @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    </div>
    """
  end

  def datetime_local_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= datetime_local_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def datetime_select(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <div class="select-wrapper dark:text-white">
      <%= datetime_select @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    </div>
    """
  end

  def date_select(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <div class="select-wrapper dark:text-white">
      <%= date_select @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    </div>
    """
  end

  def date_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= date_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def color_input(assigns) do
    assigns = assign_defaults(assigns, color_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= color_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def file_input(assigns) do
    assigns = assign_defaults(assigns, file_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= file_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def range_input(assigns) do
    assigns = assign_defaults(assigns, range_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= range_input @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def textarea(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= textarea @form, @field, [class: @classes, rows: "4", phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def select(assigns) do
    assigns = assign_defaults(assigns, select_classes(field_has_errors?(assigns)))

    ~H"""
    <%= select @form, @field, @options, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def checkbox(assigns) do
    assigns = assign_defaults(assigns, checkbox_classes(field_has_errors?(assigns)))

    ~H"""
    <%= checkbox @form, @field, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def checkbox_group(assigns) do
    assigns =
      assigns
      |> assign_defaults(checkbox_classes(field_has_errors?(assigns)))
      |> assign_new(:checked, fn ->
        values =
          case input_value(assigns[:form], assigns[:field]) do
            value when is_binary(value) -> [value]
            value when is_list(value) -> value
            _ -> []
          end

        Enum.map(values, &to_string/1)
      end)
      |> assign_new(:id_prefix, fn -> input_id(assigns[:form], assigns[:field]) <> "_" end)
      |> assign_new(:layout, fn -> :col end)

    ~H"""
    <div class={checkbox_group_layout_classes(%{layout: @layout})}>
      <%= hidden_input @form, @field, name: input_name(@form, @field), value: "" %>
      <%= for {label, value} <- @options do %>
        <label class={checkbox_group_layout_item_classes(%{layout: @layout})}>
          <.checkbox
            form={@form}
            field={@field}
            id={@id_prefix <> to_string(value)}
            name={input_name(@form, @field) <> "[]"}
            checked_value={value}
            unchecked_value=""
            value={value}
            checked={to_string(value) in @checked}
            hidden_input={false}
            {@rest} />
          <div class={label_classes(%{form: @form, field: @field, type: "checkbox"})}><%= label %></div>
        </label>
      <% end %>
    </div>
    """
  end

  def switch(assigns) do
    assigns = assign_defaults(assigns, switch_classes(field_has_errors?(assigns)))

    ~H"""
    <label class="relative inline-flex items-center justify-center flex-shrink-0 w-10 h-5 group">
      <%= checkbox @form, @field, [
        class: @classes,
        phx_feedback_for: input_name(@form, @field)] ++ @rest
      %>
      <span class="absolute h-6 mx-auto transition-colors duration-200 ease-in-out bg-gray-200 border rounded-full pointer-events-none w-11 dark:bg-gray-700 dark:border-gray-600 peer-checked:bg-primary-500"></span>
      <span class="absolute left-0 inline-block w-5 h-5 transition-transform duration-200 ease-in-out transform translate-x-0 bg-white rounded-full shadow pointer-events-none peer-checked:translate-x-5 ring-0 "></span>
    </label>
    """
  end

  def radio(assigns) do
    assigns = assign_defaults(assigns, radio_classes(field_has_errors?(assigns)))

    ~H"""
    <%= radio_button @form, @field, @value, [class: @classes, phx_feedback_for: input_name(@form, @field)] ++ @rest %>
    """
  end

  def radio_group(assigns) do
    assigns =
      assigns
      |> assign_defaults(radio_classes(field_has_errors?(assigns)))
      |> assign_new(:layout, fn -> :col end)

    ~H"""
    <div class={radio_group_layout_classes(%{layout: @layout})}>
      <%= for {label, value} <- @options do %>
        <label class={radio_group_layout_item_classes(%{layout: @layout})}>
          <.radio form={@form} field={@field} value={value} {@rest} />
          <div class={label_classes(%{form: @form, field: @field, type: "radio"})}><%= label %></div>
        </label>
      <% end %>
    </div>
    """
  end

  # <.form_field_error form={f} field={:name} />
  def form_field_error(assigns) do
    assigns = assign_new(assigns, :class, fn -> "" end)
    translate_error = translator_from_config() || (&translate_error/1)

    ~H"""
    <div class={@class}>
      <%= for error <- Keyword.get_values(@form.errors, @field) do %>
        <div class="text-xs italic text-red-500 invalid-feedback" phx-feedback-for={input_name(@form, @field)}>
          <%= translate_error.(error) %>
        </div>
      <% end %>
    </div>
    """
  end

  defp translate_error({msg, opts}) do
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      try do
        String.replace(acc, "%{#{key}}", to_string(value))
      rescue
        e ->
          IO.warn(
            """
            the fallback message translator for the form_field_error function cannot handle the given value.

            Hint: you can set up the `error_translator_function` to route all errors to your application helpers:

              config :petal_components, :error_translator_function, {MyAppWeb.ErrorHelpers, :translate_error}

            Given value: #{inspect(value)}

            Exception: #{Exception.message(e)}
            """,
            __STACKTRACE__
          )

          "invalid value"
      end
    end)
  end

  defp translator_from_config do
    case Application.get_env(:petal_components, :error_translator_function) do
      {module, function} -> &apply(module, function, [&1])
      nil -> nil
    end
  end

  defp assign_defaults(assigns, base_classes) do
    assigns
    |> assign_new(:type, fn -> "text" end)
    |> assign_rest(~w(class label form field type options layout)a)
    |> assign_new(:classes, fn ->
      build_class([
        base_classes,
        assigns[:class]
      ])
    end)
  end

  defp label_classes(assigns) do
    type_classes =
      if Enum.member?(["checkbox", "radio"], assigns[:type]) do
        ""
      else
        "mb-2 font-medium"
      end

    "#{if field_has_errors?(assigns), do: "has-error", else: ""} #{type_classes} text-sm block text-gray-900 dark:text-gray-200"
  end

  defp text_input_classes(has_error) do
    "#{if has_error, do: "has-error", else: ""} border-gray-300 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-600 dark:focus:border-primary-500 sm:text-sm block disabled:bg-gray-100 disabled:cursor-not-allowed shadow-sm w-full rounded-md dark:bg-gray-800 dark:text-gray-300 focus:outline-none focus:ring-primary-500 focus:border-primary-500"
  end

  defp select_classes(has_error) do
    "#{if has_error, do: "has-error", else: ""} border-gray-300 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-600 dark:focus:border-primary-500 block w-full disabled:bg-gray-100 disabled:cursor-not-allowed pl-3 pr-10 py-2 text-base focus:outline-none sm:text-sm rounded-md dark:border-gray-600 dark:focus:border-primary-500 dark:text-gray-300 dark:bg-gray-800"
  end

  defp file_input_classes(has_error) do
    "#{if has_error, do: "has-error", else: ""} focus:outline-none file:border-0 rounded-md text-sm text-slate-500 file:text-primary-700 file:font-semibold file:px-4 file:py-2 file:mr-6 file:rounded-md hover:file:bg-primary-100 file:bg-primary-200 dark:file:bg-gray-800 dark:file:text-primary-500"
  end

  defp color_input_classes(has_error) do
    "#{if has_error, do: "has-error", else: ""} border-gray-300 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-600 dark:focus:border-primary-500"
  end

  defp range_input_classes(has_error) do
    "#{if has_error, do: "has-error", else: ""} border-gray-300 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-600 dark:focus:border-primary-500 w-full"
  end

  defp checkbox_classes(has_error) do
    "#{if has_error, do: "has-error", else: ""} border-gray-300 text-primary-700 rounded w-5 h-5 ease-linear transition-all duration-150 dark:bg-gray-800 dark:border-gray-600"
  end

  defp checkbox_group_layout_classes(assigns) do
    case assigns[:layout] do
      :row ->
        "flex flex-row gap-4"

      _col ->
        "flex flex-col gap-3"
    end
  end

  defp checkbox_group_layout_item_classes(assigns) do
    case assigns[:layout] do
      :row ->
        "inline-flex items-center block gap-2"

      _col ->
        "inline-flex items-center block gap-3"
    end
  end

  defp switch_classes(has_error) do
    "#{if has_error, do: "has-error", else: ""} absolute w-10 h-5 bg-white border-none rounded-full cursor-pointer peer checked:border-0 checked:bg-transparent checked:focus:bg-transparent checked:hover:bg-transparent dark:bg-gray-800"
  end

  defp radio_group_layout_classes(assigns) do
    case assigns[:layout] do
      :row ->
        "flex flex-row gap-4"

      _col ->
        "flex flex-col gap-1"
    end
  end

  defp radio_group_layout_item_classes(assigns) do
    case assigns[:layout] do
      :row ->
        "inline-flex items-center gap-2"

      _col ->
        "inline-flex items-center gap-3"
    end
  end

  defp radio_classes(has_error) do
    "#{if has_error, do: "has-error", else: ""} border-gray-300 h-4 w-4 cursor-pointer text-primary-600 focus:ring-primary-500 dark:bg-gray-800 dark:border-gray-600"
  end

  defp field_has_errors?(%{form: form, field: field}) do
    case Keyword.get_values(form.errors, field) do
      [] -> false
      _ -> true
    end
  end

  defp field_has_errors?(_), do: false
end
