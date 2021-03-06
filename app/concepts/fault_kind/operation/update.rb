class FaultKind::Update < BaseOperation
  class Present < BaseOperation
    step Model(FaultKind, :find_by)
    failure :record_not_found!
    step Policy::Pundit(FaultKindPolicy, :update?)
    failure :not_authorized!
    step Contract::Build(constant: FaultKind::Contract::Base)
  end

  step Nested(Present)
  step Contract::Validate(key: :fault_kind)
  failure :contract_invalid!
  step Contract::Persist()
  step ->(options, **) { options['result.message'] = I18n.t('fault_kinds.updated') }
end